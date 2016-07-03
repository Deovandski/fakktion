#!/bin/bash

# Colors for Scrip Messages.
warn=$(tput setaf 5; tput bold; tput setab 0)
inform=$(tput setaf 6; tput bold; tput setab 0)
reset=$(tput sgr0)

# Error Detection
watchForErrors(){
  exitStatus="$1"
  step="$2"
  action="$3"
  if [ "$exitStatus" -eq 0 ]
  then
    echo "${inform}OK${reset} | $step"
  else
    echo "${warn}ERROR $exitStatus ${reset} |$step"
    echo "${warn}$action${reset}"
  fi
}

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
  deployUser="$1"
  if [ $# -eq 4 ]
  then
    databaseUser="$3"
    deployDBName="$4"
  fi
  # Make sure that we are in the proper place.
  cd /home/"$USER"/Fakktion || return
  # Check GemFile.lock for exactly what is being installed from https://rubygems.org/.
  
  echo "${inform}Install NPM and Nodejs through N...${reset}"
  # Install NPM (Node.js Package Manager) followed by installing Node.js
  # The install methodology below avoids the use of NVM (node version manager.)
  sudo apt-get -y install npm
  watchForErrors $? "NPM install" "install npm mannually"
  sudo npm cache clean -f
  # n package which install latest stabe NodeJS | https://www.npmjs.com/package/n
  # Using apt-get not recommend due to lack of support. https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
  sudo npm install -g n
  sudo n stable
  watchForErrors $? "NODE install" "install node mannually"

  # Fix any ownership issues that may rise from the use of sudo.
  # Why use Sudo in the first place? because non-sudo installs often lead to issues, and the initial sudo install
  # guarantees that the chances of something going haywire is minimal.
  sudo chown -R "$(whoami)" "$(npm config get prefix)"/{lib/node_modules,bin,share}

  # Get ownership of the files being transfered to prevent write permissions from other users, or fix any existing file permission issues...
  sudo chown -R "$USER" /home/"$USER"/Fakktion
  watchForErrors $? "NPM/NODE permissions change" "Fix ownership issues mannually"
  echo "${inform}Bundler Install...${reset}"
  bundle install
  watchForErrors $? "BUNDLER install" "Run bundler install mannually"
  
  echo "${inform}NPM and Bower dependencies install...${reset}"
  # Install all Fakktion frontend dependencies
  cd frontend || return
  # NPM install takes care of Ember CLI Middleware
  npm install
  watchForErrors $? "NPM dependencies install" "install Fakktion NPM dependencies mannually"
  # Bower takes care of Ember.js (Ember.js !== Ember CLI)
  npm install -g bower
  watchForErrors $? "Bower install" "install Bower globally mannually"
  bower install
  watchForErrors $? "Bower dependencies install" "install Fakktion Bower dependencies mannually"
  cd ..

  # Puma configuration
  echo "${inform}Creating puma.rb according to system configs...${reset}"
  echo "" > config/puma.rb
  watchForErrors $? "Clear puma config file" "Empty config/puma.rb yourself then try again"
  echo "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
  watchForErrors $? "Creating puma.rb according to system configs..." "Could not get number of processors currently available"
  cat docs/source/partial_puma_16.txt >> config/puma.rb
  watchForErrors $? "Inject the rest of Puma configs" "Check config/puma.rb and partial_puma_16.txt yourself then try again"

  # Set unique local secrets.yml
  echo "${inform}Setting Unique Rails Secret used for managing sessions...${reset}"
  echo "" > config/secrets.yml
  watchForErrors $? "Empty config/secrets.yml" "Mannually empty config/secrets.yml"
  cat docs/source/partial_secrets_16.txt >> config/secrets.yml
  watchForErrors $? "Adding rails secrets information" "Check partial_secrets_16.txt and config/secrets.yml"
  echo "  secret_key_base: $(rake secret)" >> config/secrets.yml
  watchForErrors $? "Setting New Rails Secret used for managing sessions..." "Run rake secret and paste it into config/secrets.yml"

  # Create necessary folders and files.
  mkdir /home/"$USER"/Fakktion/tmp
  watchForErrors $? "MKDIR /Fakktion/tmp" ""
  mkdir /home/"$USER"/Fakktion/tmp/puma
  watchForErrors $? "MKDIR /Fakktion/tmp/puma" ""
  touch /home/"$USER"/Fakktion/tmp/puma/pid
  watchForErrors $? "TOUCH /Fakktion/tmp/puma/pid" ""
  touch /home/"$USER"/Fakktion/tmp/puma/state
  watchForErrors $? "TOUCH /Fakktion/tmp/puma/state" ""
  mkdir /home/"$USER"/Fakktion/log
  watchForErrors $? "MKDIR /Fakktion/log" ""
  touch /home/"$USER"/Fakktion/log/puma.log
  watchForErrors $? "TOUCH /Fakktion/log/puma.log" ""
  mkdir /home/"$USER"/Fakktion/shared
  watchForErrors $? "MKDIR /Fakktion/shared" ""
  mkdir /home/"$USER"/Fakktion/shared/log
  watchForErrors $? "MKDIR /Fakktion/shared/log" ""
  mkdir /home/"$USER"/Fakktion/shared/sockets
  watchForErrors $? "MKDIR /Fakktion/shared/sockets" ""
  touch /home/"$USER"/Fakktion/shared/sockets/puma.sock
  watchForErrors $? "TOUCH /Fakktion/shared/sockets/puma.sock" ""
  touch /home/"$USER"/Fakktion/shared/log/puma.stderr.log
  watchForErrors $? "TOUCH /Fakktion/shared/log/puma.stderr.log" ""
  touch /home/"$USER"/Fakktion/shared/log/puma.stdout.log
  watchForErrors $? "TOUCH /Fakktion/shared/log/puma.stdout.log" ""
  
  # Setup for Symbolic link
  sudo mkdir /var/www/Fakktion
  watchForErrors $? "MKDIR /var/www/Fakktion" ""
  sudo mkdir /var/www/Fakktion/shared
  watchForErrors $? "MKDIR /var/www/Fakktion/shared" ""
  sudo mkdir /var/www/Fakktion/shared/sockets
  watchForErrors $? "MKDIR /var/www/Fakktion/shared/sockets" ""

  # Create Symlinks on /var/www for future NGINX connection to PUMA
  sudo ln -s /home/"$USER"/Fakktion/shared/sockets/puma.sock /var/www/Fakktion/shared/sockets/puma.sock
  watchForErrors $? "LN for /var/www/Fakktion/shared/sockets/puma.sock" ""
  sudo ln -s /home/"$USER"/Fakktion/public /var/www/Fakktion/public
  watchForErrors $? "LN for /var/www/Fakktion/public" ""
  
  # Database SETUP
  if [ "$2" = "n" ] || [ "$2" = "no" ]
  then
    sudo apt-get install postgresql postgresql-contrib
    watchForErrors $? "Setting up PostgreSQL as local server mode " "Check the scripts mannually"
    echo "${inform}A Postgres User with name $databaseUser will now be created. Please enter the password for it, and don't forget to write it down!${reset}'"
    sudo -u postgres createuser --superuser "$databaseUser" --pwprompt
    sudo -u "$databaseUser" createdb "$deployDBName"
  else
    sudo apt-get install postgresql-client
    watchForErrors $? "Setting up PostgreSQL as client mode" "Check the scripts mannually"
  fi
  rake db:setup RAILS_ENV=production
  watchForErrors $? "Rake db migration and seeding" "run rake db:setup mannually"
}

# Setup Puma
setupPuma(){
  deployUser="$1"
  
  echo "${inform}$deployUser is no longer a sudo user...${reset}"
  # Copy the init script to services directory 
  cp puma /etc/init.d
  watchForErrors $? "Copy the init script to services directory" ""
  chmod +x /etc/init.d/puma

  # Make it start at boot time. 
  update-rc.d -f puma defaults
  watchForErrors $? "Make PUMA run at boot time" ""

  # Copy the Puma runner to an accessible location
  cp run-puma /usr/local/bin
  watchForErrors $? "Make PUMA accessible from /usr/local/bin" ""
  chmod +x /usr/local/bin/run-puma
  watchForErrors $? "Make PUMA chmox +x on /usr/local/bin" ""

  # Create an empty configuration file
  touch /etc/puma.conf
  watchForErrors $? "TOUCH /etc/puma.conf" ""

  # Link Fakktion to Puma
  /etc/init.d/puma add /home/"$deployUser"/Fakktion "$deployUser" /home/"$deployUser"/Fakktion/config/puma.rb /home/"$deployUser"/Fakktion/log/puma.log
  watchForErrors $? "Add Fakktion into PUMA" ""

  cd shared/log || return
  nano puma.stderr.log
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
  watchForErrors $? "NGINX restart" ""
}

prepareApp(){
  deployUser="$1"
  cd ..
  rake assets:precompile
  watchForErrors $? "Precompile Fakktion" ""
  bundle exec puma -e production -d -b unix:///home/"$deployUser"/Fakktion/shared/sockets/puma.sock
  watchForErrors $? "Start Fakktion" ""
  cd shared/log || return
  nano puma.stderr.log
  echo "${inform}App is ready! Now opening log for confirmation...${reset}"
}

if [ $# -eq 0 ]
then
  echo "${warn}No arguments provided. See Below for Usage according to each step:${reset}"
  echo "1 User"
  echo "2 User y fakktionDBUser fakktionDB"
  echo "2 User n"
  echo "3 User"
  echo "4 User SSSL?"
  echo "5 User "
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
    if [ $# -eq 5 ]
    then
      setupApp "$2" "$3" "$4" "$5"
    elif [ $# -eq 3 ]
    then
      if [ "$3" = "y" ] || [ "$3" = "yes" ]
      then
        setupApp "$2" "$3"
      else
        echo "${warn}Local Database setup must contain DBUSER DBNAME arguments.${reset}"
      fi
    else
      echo "${warn}Wrong number of arguments.${reset}"
      echo "Usage: Step User remoteDatabase? DBUSER DBNAME"
      echo "Example: 2 User y fakktionDBUser fakktionDB"
      echo "Example: 2 User n"
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
    if [ $# -eq 2 ]
    then
      prepareApp "$2"
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step user"
      echo "Example: 5 USER "
    fi
  fi
fi

