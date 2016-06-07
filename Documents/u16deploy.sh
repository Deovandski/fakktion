#!/bin/bash

setupBaseReqs(){
  deployUser="$1"
  # Min necessary for NGINX, Postgres, Ruby, Bundler and Rails.
  sudo apt-get install -y libpq-dev nginx ruby2.3 rails bundler
  # Note regarding using apt-get for every needed package instead of Bundler.
  # This is a non-DRY approach, and many packages may not be available (especially edge versions.)
  # An example of it is ruby-active-model-serializers where apt-get only displays 0.9.3 when Fakktion needs 0.10.0.rc5
  if getent passwd "$1" > /dev/null 2>&1
  then
    if [ -d "/home/$deployUser/Fakktion" ]
    then
      cd /home/"$deployUser"/Fakktion
    else
      sudo mv /home/"$USER"/Fakktion /home/"$deployUser/Fakktion"
    fi
    echo "Base Reqs Finished"
  else
    echo "$deployUser does not exist."
    echo "run sudo adduser, followed by sudo passwd"
    RED='\033[0;31m'
    NC='\033[0m'
    echo "${RED}DO NOT MOVE TO STEP 2!${NC} RETRY STEP 1 AFTER CREATING USER"
  fi
  
}
setupApp(){
  deployUser="$1"
  deployDBName="$2"
  # Make sure that we are in the proper place.
  cd /home/"$deployUser"/Fakktion
  # Check GemFile.lock for exactly what is being installed from https://rubygems.org/.
  bundle install
  
  # Install NPM (Node.js Package Manager) followed by installing Node.js
  # The install methodology below avoids the use of NVM (node version manager.)
  sudo apt-get -y install npm
  sudo npm cache clean -f
  # n package which install latest stabe NodeJS | https://www.npmjs.com/package/n
  sudo npm install -g n
  sudo n stable

  # Fix any ownership issues that may rise from the use of sudo.
  # Why use Sudo in the first place? because non-sudo installs often lead to issues, and the initial sudo install
  # guarantees that the chances of something going haywire is minimal.
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

  # Install all Fakktion frontend dependencies
  cd frontend
  # NPM install takes care of Ember CLI Middleware
  npm install
  # Bower takes care of Ember.js (Ember.js !== Ember CLI)
  npm install -g bower
  bower install
  cd ..

  # Puma configuration
  echo "" > config/puma.rb
  echo "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
  cat Documents/partial_puma_16.txt >> config/puma.rb

  # Set unique local secrets.yml
  echo "Setting Unique Secret"
  echo "" > config/secrets.yml
  cat Documents/partial_secrets_16.txt >> config/secrets.yml
  echo "  secret_key_base: $(rake secret)" >> config/secrets.yml

  # Database SETUP
  echo "A Postgres User with name $deployUser will now be created. Please enter the password for it, and don't forget to write it down!'"
  sudo -u postgres createuser --superuser "$deployUser" --pwprompt
  echo "Creating the $deployDBName database'"
  sudo -u "$deployUser" createdb "$deployDBName"

  # Create necessary folders and files.
  echo "Creating necessary folders..."
  mkdir /home/"$deployUser"/Fakktion/tmp
  mkdir /home/"$deployUser"/Fakktion/tmp/puma
  touch /home/"$deployUser"/Fakktion/tmp/puma/pid
  touch /home/"$deployUser"/Fakktion/tmp/puma/state
  mkdir /home/"$deployUser"/Fakktion/log
  touch /home/"$deployUser"/Fakktion/log/puma.log
  mkdir /home/"$deployUser"/Fakktion/shared
  mkdir /home/"$deployUser"/Fakktion/shared/log
  mkdir /home/"$deployUser"/Fakktion/shared/sockets
  touch /home/"$deployUser"/Fakktion/shared/sockets/puma.sock
  touch /home/"$deployUser"/Fakktion/shared/log/puma.stderr.log
  touch /home/"$deployUser"/Fakktion/shared/log/puma.stdout.log

  # Create Symlinks on /var/www for future NGINX connection to PUMA
  sudo ln -s /home/"$deployUser"/Fakktion/shared/sockets/puma.sock /var/www/Fakktion/shared/sockets/puma.sock
  sudo ln -s /home/"$deployUser"/Fakktion/public /var/www/Fakktion/public
  
  # Precompile App.
  echo "precompiling Fakktion"
  rake assets:precompile

  # Setup Database.
  echo "Configs for Fakktion database underway..."
  rake db:setup RAILS_ENV=production

}

# Setup Puma
setupPuma(){
  deployUser="$1"
  # Copy the init script to services directory 
  cp puma /etc/init.d
  chmod +x /etc/init.d/puma

  # Make it start at boot time. 
  update-rc.d -f puma defaults

  # Copy the Puma runner to an accessible location
  cp run-puma /usr/local/bin
  chmod +x /usr/local/bin/run-puma

  # Create an empty configuration file
  touch /etc/puma.conf

  # Link Fakktion to Puma
  /etc/init.d/puma add /home/"$deployUser"/Fakktion "$deployUser" /home/"$deployUser"/Fakktion/config/puma.rb /home/"$deployUser"/Fakktion/log/puma.log

  echo "PUMA is ready!"
}

setupNGINX(){
  deployUser="$1"
  # Purges default NGINX configs.
  echo "" > /etc/nginx/sites-available/default
  if [ "$2" = "y" ] || [ "$2" = "yes" ]
  then
    cat fakktion_16_ssl.conf >> /etc/nginx/sites-available/default
  else
    cat fakktion_16_non_ssl.conf >> /etc/nginx/sites-available/default
  fi
  service nginx restart
  echo "NGINX is ready!"
}




if [ $# -eq 0 ]
then
  echo "No arguments provided. See Below for Usage according to each step:"
  echo "1 User"
  echo "2 User"
  echo "3 User"
  echo "4 User SSSL?"
else    
  if [ "$1" = 1 ]
  then
    if [ $# -eq 2 ]
    then
      setupBaseReqs "$2"
    else
      echo "User in which Puma should use to run Fakktion was not provided."
      echo "Usage: Step user"
      echo "Example: 1 fakktionApp"
    fi
  elif [ "$1" = 2 ]
  then
    if [ $# -eq 3 ]
    then
      setupApp "$2" "$3"
    else
      echo "User in which Puma should use to run Fakktion was not provided."
      echo "Usage: Step user DBNAME"
      echo "Example: 2 fakktionApp fakktionDB"
    fi
  
  elif [ "$1" = 3 ]
  then
    if [ $# -eq 2 ]
    then
      setupPuma "$2"
    else
      echo "User in which Puma should use to run Fakktion was not provided."
      echo "Usage: Step user"
      echo "Example: 3 fakktionApp"
    fi
  elif [ "$1" = 4 ]
  then
    if [ $# -eq 3 ]
    then
      setupNGINX "$2" "$3"
    else
      echo "Incorrect # of arguments..."
      echo "Usage: Step user SSLConfig? "
      echo "Example: 4 fakktionApp y/n "
    fi
  fi
fi

