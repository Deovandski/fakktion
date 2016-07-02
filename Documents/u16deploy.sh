#!/bin/bash

# Colors for Scrip Messages.
warn=$(tput setaf 5; tput bold; tput setab 0)
inform=$(tput setaf 6; tput bold; tput setab 0)
reset=$(tput sgr0)

setupBaseReqs(){
  deployUser="$1"
  # Min necessary for NGINX, Ruby, Bundler and Rails.
  sudo apt-get install -y nginx ruby2.3 rails bundler
  # Note regarding using apt-get for every needed package instead of Bundler.
  # This is a non-DRY approach, and many packages may not be available (especially edge versions.)
  # An example of it is ruby-active-model-serializers where apt-get only displays 0.9.3 when Fakktion needs 0.10.0.rc5
  if getent passwd "$1" > /dev/null 2>&1
  then
    if [ -d "/home/$deployUser/Fakktion" ]
    then
      cd /home/"$deployUser"/Fakktion || return
    else
      sudo mv /home/"$USER"/Fakktion /home/"$deployUser/Fakktion"
      sudo adduser "$deployUser" sudo
    fi
    echo "${inform}Base Reqs Finished${reset}"
  else
    echo "$deployUser does not exist."
    echo "${warn} DO NOT FOLLOW THE NEXT STEP! ${reset}"
    echo "${warn} RUN: sudo adduser $deployUser ${reset}, then try again!"
  fi
  
}
setupApp(){
  if [ $# -eq 3 ]
  then
    databaseUser="$2"
    deployDBName="$3"
  fi
  # Make sure that we are in the proper place.
  cd /home/"$USER"/Fakktion || return
  # Check GemFile.lock for exactly what is being installed from https://rubygems.org/.
  
  echo "${inform}Install NPM and Nodejs through N...${reset}"
  # Install NPM (Node.js Package Manager) followed by installing Node.js
  # The install methodology below avoids the use of NVM (node version manager.)
  sudo apt-get -y install npm
  sudo npm cache clean -f
  # n package which install latest stabe NodeJS | https://www.npmjs.com/package/n
  # Using apt-get not recommend due to lack of support. https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
  sudo npm install -g n
  sudo n stable

  # Fix any ownership issues that may rise from the use of sudo.
  # Why use Sudo in the first place? because non-sudo installs often lead to issues, and the initial sudo install
  # guarantees that the chances of something going haywire is minimal.
  sudo chown -R "$(whoami)" "$(npm config get prefix)"/{lib/node_modules,bin,share}

  # Get ownership of the files being transfered to prevent write permissions from other users, or fix any existing file permission issues...
  sudo chown -R "$USER" /home/"$USER"/Fakktion
  echo "${inform}Bundler Install...${reset}"
  bundle install
  
  echo "${inform}NPM and Bower dependencies install...${reset}"
  # Install all Fakktion frontend dependencies
  cd frontend || return
  # NPM install takes care of Ember CLI Middleware
  npm install
  # Bower takes care of Ember.js (Ember.js !== Ember CLI)
  npm install -g bower
  bower install
  cd ..

  # Puma configuration
  echo "${inform}Creating puma.rb according to system configs...${reset}"
  echo "" > config/puma.rb
  echo "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
  cat Documents/partial_puma_16.txt >> config/puma.rb

  # Set unique local secrets.yml
  echo "${inform}Setting Unique Rails Secret used for managing sessions...${reset}"
  echo "" > config/secrets.yml
  cat Documents/partial_secrets_16.txt >> config/secrets.yml
  echo "  secret_key_base: $(rake secret)" >> config/secrets.yml

  # Create necessary folders and files.
  echo "${inform}Creating necessary folders...${reset}"
  mkdir /home/"$USER"/Fakktion/tmp
  mkdir /home/"$USER"/Fakktion/tmp/puma
  touch /home/"$USER"/Fakktion/tmp/puma/pid
  touch /home/"$USER"/Fakktion/tmp/puma/state
  mkdir /home/"$USER"/Fakktion/log
  touch /home/"$USER"/Fakktion/log/puma.log
  mkdir /home/"$USER"/Fakktion/shared
  mkdir /home/"$USER"/Fakktion/shared/log
  mkdir /home/"$USER"/Fakktion/shared/sockets
  touch /home/"$USER"/Fakktion/shared/sockets/puma.sock
  touch /home/"$USER"/Fakktion/shared/log/puma.stderr.log
  touch /home/"$USER"/Fakktion/shared/log/puma.stdout.log
  
  # Setup for Symbolic link
  echo "${inform}Setting up Symbolic Link to /var/www/Fakktion...${reset}"
  sudo mkdir /var/www/Fakktion
  sudo chown -R "$USER" /var/www/Fakktion
  mkdir /var/www/Fakktion/shared
  mkdir /var/www/Fakktion/shared/sockets
  # Create Symlinks on /var/www for future NGINX connection to PUMA
  ln -s /home/"$USER"/Fakktion/shared/sockets/puma.sock /var/www/Fakktion/shared/sockets/puma.sock
  ln -s /home/"$USER"/Fakktion/public /var/www/Fakktion/public
  
  # Database SETUP
  if [ "$3" = "y" ] || [ "$3" = "yes" ]
  then
    echo "${inform}Setting up PostgreSQL as local server mode ${reset}'"
    sudo apt-get install postgresql postgresql-contrib
    echo "${inform}A Postgres User with name $databaseUser will now be created. Please enter the password for it, and don't forget to write it down!${reset}'"
    sudo -u postgres createuser --superuser "$databaseUser" --pwprompt
    echo "${inform}Creating the $deployDBName database${reset}'"
    sudo -u "$databaseUser" createdb "$deployDBName"
    echo "${inform}Configs for Fakktion database underway...${reset}"
    rake db:setup RAILS_ENV=production
  else
    echo "${inform}Setting up PostgreSQL as client mode ${reset}'"
    sudo apt-get install postgresql-client
    echo "${warn}Please run the following comman setup skipped${reset}'"
    echo "${inform}Configs for Fakktion database underway...${reset}"
    rake db:setup RAILS_ENV=production
  fi
  echo "${inform}If an error ocurred at this point, please execute the Database SETUP section of the setupAPP() manually...${reset}"

}

# Setup Puma
setupPuma(){
  deployUser="$1"
  deluser "$deployUser" sudo
  echo "${inform}$deployUser is no longer a sudo user...${reset}"
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

  echo "${inform}PUMA is ready!${reset}"
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
  echo "${inform}NGINX is ready!${reset}"
}

prepareApp(){
  cd ..
  rake assets:precompile
  bundle exec puma -e production -d -b unix:///var/www/Fakktion/shared/sockets/puma.sock
  cd shared/log || return
  nano puma.stderr.log
  echo "${inform}App is ready! Now opening log for confirmation...${reset}"
}

if [ $# -eq 0 ]
then
  echo "${warn}No arguments provided. See Below for Usage according to each step:${reset}"
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
      echo "${warn}User in which Puma should use to run Fakktion was not provided.${reset}"
      echo "Usage: Step user"
      echo "Example: 1 fakktionApp"
    fi
  elif [ "$1" = 2 ]
  then
    if [ $# -eq 4 ]
    then
      setupApp "$2" "$3" "$4"
    elif [ $# -eq 2 ]
    then
      if [ "$2" = "y" ] || [ "$2" = "yes" ]
      then
        setupApp "$2"
      else
        echo "${warn}Local Database setup must contain DBUSER DBNAME arguments.${reset}"
      fi
    else
      echo "${warn}Wrong number of arguments.${reset}"
      echo "Usage: Step remoteDatabase? DBUSER DBNAME"
      echo "Example: 2 y fakktionDBUser fakktionDB"
      echo "Example: 2 n"
    fi
  elif [ "$1" = 3 ]
  then
    if [ $# -eq 2 ]
    then
      setupPuma "$2"
    else
      echo "${warn}User in which Puma should use to run Fakktion was not provided.${reset}"
      echo "Usage: Step user"
      echo "Example: 3 fakktionApp"
    fi
  elif [ "$1" = 4 ]
  then
    if [ $# -eq 3 ]
    then
      setupNGINX "$2" "$3"
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step user SSLConfig? "
      echo "Example: 4 fakktionApp y/n "
    fi
  elif [ "$1" = 5 ]
  then
    if [ $# -eq 1 ]
    then
      prepareApp
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step"
      echo "Example: 5 "
    fi
  fi
fi

