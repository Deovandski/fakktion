#!/bin/bash
# u16deploy.sh v2.2
# Ubuntu Server 16.04 deployment

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
    echo "${warn}ERROR ${inform} $exitStatus ${reset} |$step"
    echo "${warn}$action${reset}"
    exit
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
  cd /home/"$deployUser"/Fakktion || return
  # Check GemFile.lock for exactly what is being installed from https://rubygems.org/.
  
  # Min necessary for NGINX, Postgres, Ruby, Bundler and Rails.
  sudo apt-get install -y libpq-dev nginx ruby2.3 rails bundler
  # !!!Note regarding using apt-get for every needed package instead of Bundler, NPM and Bower.!!!
  # This is an approach that will cost your soul due to the increased cost in maintenance and error prone micro-management.
  # If that does not deter you from doing it, then be aware that many packages may not be available (especially edge versions.)
  # I warned you, so I will not be friendly if you ask for assistance because micro-managing packages f****d up your server.
  
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
  sudo chown -R "$deployUser" /home/"$deployUser"/Fakktion
  watchForErrors $? "NPM/NODE permissions change" "Fix ownership issues mannually"
  bundle install
  watchForErrors $? "BUNDLER install" "Run bundler install mannually"
  
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
  echo "" > /home/"$deployUser"/Fakktion/config/puma.rb
  watchForErrors $? "Clear puma config file" "Empty config/puma.rb yourself then try again"
  echo "workers $(grep -c processor /proc/cpuinfo)" >> /home/"$deployUser"/Fakktion/config/puma.rb
  watchForErrors $? "Creating puma.rb according to system configs..." "Could not get number of processors currently available"
  cat /home/"$deployUser"/Fakktion/docs/sources/partial_puma_16.txt >> /home/"$deployUser"/Fakktion/config/puma.rb
  watchForErrors $? "Inject the rest of Puma configs" "Check config/puma.rb and partial_puma_16.txt yourself then try again"

  # Set unique local secrets.yml
  echo "" > /home/"$deployUser"/Fakktion/config/secrets.yml
  watchForErrors $? "Empty config/secrets.yml" "Mannually empty config/secrets.yml"
  cat /home/"$deployUser"/Fakktion/docs/sources/partial_secrets_16.txt >> /home/"$deployUser"/Fakktion/config/secrets.yml
  watchForErrors $? "Adding rails secrets information" "Check partial_secrets_16.txt and config/secrets.yml"
  echo "  secret_key_base: $(rake secret)" >> /home/"$deployUser"/Fakktion/config/secrets.yml
  watchForErrors $? "Setting New Rails Secret used for managing sessions..." "Run rake secret and paste it into config/secrets.yml"

  # Create necessary folders and files.
  mkdir /home/"$deployUser"/Fakktion/tmp
  watchForErrors $? "MKDIR /Fakktion/tmp" ""
  mkdir /home/"$deployUser"/Fakktion/tmp/puma
  watchForErrors $? "MKDIR /Fakktion/tmp/puma" ""
  touch /home/"$deployUser"/Fakktion/tmp/puma/pid
  watchForErrors $? "TOUCH /Fakktion/tmp/puma/pid" ""
  touch /home/"$deployUser"/Fakktion/tmp/puma/state
  watchForErrors $? "TOUCH /Fakktion/tmp/puma/state" ""
  mkdir /home/"$deployUser"/Fakktion/log
  watchForErrors $? "MKDIR /Fakktion/log" ""
  touch /home/"$deployUser"/Fakktion/log/puma.log
  watchForErrors $? "TOUCH /Fakktion/log/puma.log" ""
  mkdir /home/"$deployUser"/Fakktion/shared
  watchForErrors $? "MKDIR /Fakktion/shared" ""
  mkdir /home/"$deployUser"/Fakktion/shared/log
  watchForErrors $? "MKDIR /Fakktion/shared/log" ""
  mkdir /home/"$deployUser"/Fakktion/shared/sockets
  watchForErrors $? "MKDIR /Fakktion/shared/sockets" ""
  touch /home/"$deployUser"/Fakktion/shared/sockets/puma.sock
  watchForErrors $? "TOUCH /Fakktion/shared/sockets/puma.sock" ""
  touch /home/"$deployUser"/Fakktion/shared/log/puma.stderr.log
  watchForErrors $? "TOUCH /Fakktion/shared/log/puma.stderr.log" ""
  touch /home/"$deployUser"/Fakktion/shared/log/puma.stdout.log
  watchForErrors $? "TOUCH /Fakktion/shared/log/puma.stdout.log" ""
  
  # Setup for Symbolic link
  sudo mkdir /var/www/Fakktion
  watchForErrors $? "MKDIR /var/www/Fakktion" ""
  sudo mkdir /var/www/Fakktion/shared
  watchForErrors $? "MKDIR /var/www/Fakktion/shared" ""
  sudo mkdir /var/www/Fakktion/shared/sockets
  watchForErrors $? "MKDIR /var/www/Fakktion/shared/sockets" ""

  # Create Symlinks on /var/www for future NGINX connection to PUMA
  sudo ln -s /home/"$deployUser"/Fakktion/shared/sockets/puma.sock /var/www/Fakktion/shared/sockets/puma.sock
  watchForErrors $? "LN for /var/www/Fakktion/shared/sockets/puma.sock" ""
  sudo ln -s /home/"$deployUser"/Fakktion/public /var/www/Fakktion/public
  watchForErrors $? "LN for /var/www/Fakktion/public" ""
  
  # Database SETUP
  if [ "$2" = "y" ] || [ "$2" = "yes" ]
  then
    sudo apt-get install -y postgresql-client
    watchForErrors $? "Setup PostgreSQL as client mode" "Check the scripts"
  else
    sudo apt-get install -y postgresql
    watchForErrors $? "Setup PostgreSQL as Local Server mode" "Check the scripts"
    watchForErrors $? "Setup up PostgreSQL as local server mode " "Check the scripts mannually"
    echo "${inform}A Postgres User with name $databaseUser will now be created. Please enter the password for it, and don't forget to write it down!${reset}'"
    sudo -u postgres createuser --superuser "$databaseUser" --pwprompt
    watchForErrors $? "PostgreSQL Local Server mode - Create User" "Check the scripts"
    sudo -u postgres createdb -O "$databaseUser" "$deployDBName"
    watchForErrors $? "PostgreSQL Local Server mode - Create DB" "Check the scripts"
  fi
  rake db:setup RAILS_ENV=production
  watchForErrors $? "Rake db migration and seeding" "run rake db:setup mannually"
  
  # PUMA section
  
  # Copy the init script to services directory 
  sudo cp /home/"$deployUser"/Fakktion/docs/sources/puma /etc/init.d
  watchForErrors $? "Copy the init script to services directory" ""
  sudo chmod +x /etc/init.d/puma
  watchForErrors $? "PUMA init.d +x chmod permission" ""

  # Make it start at boot time. 
  sudo update-rc.d -f puma defaults
  watchForErrors $? "Make PUMA run at boot time" ""

  # Copy the Puma runner to an accessible location
  sudo cp /home/"$deployUser"/Fakktion/docs/sources/run-puma /usr/local/bin
  watchForErrors $? "Make PUMA accessible from /usr/local/bin" ""
  sudo chmod +x /usr/local/bin/run-puma
  watchForErrors $? "Make PUMA chmox +x on /usr/local/bin" ""

  # Create an empty configuration file
  sudo touch /etc/puma.conf
  watchForErrors $? "TOUCH /etc/puma.conf" ""

  # Link Fakktion to Puma
  sudo /etc/init.d/puma add /home/"$deployUser"/Fakktion "$deployUser" /home/"$deployUser"/Fakktion/config/puma.rb /home/"$deployUser"/Fakktion/log/puma.log
  watchForErrors $? "Add Fakktion into PUMA" ""

  cd /home/"$deployUser"/Fakktion/docs/shared/log || return
  nano puma.stderr.log
}

setupNGINX(){
  deployUser="$1"
  echo "" > /etc/nginx/sites-available/default
  watchForErrors $? "Purges default NGINX config" ""
  if [ "$2" = "y" ] || [ "$2" = "yes" ]
  then
    cat fakktion_16_ssl.conf >> /etc/nginx/sites-available/default
    watchForErrors $? "Transfer SSL NGINX config" ""
  else
    cat fakktion_16_non_ssl.conf >> /etc/nginx/sites-available/default
    watchForErrors $? "Transfer non-SSL NGINX config" ""
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
  echo "1 y fakktionDBUser fakktionDB"
  echo "1 n"
  echo "2 SSSL?"
  echo "3"
else
  if [ "$1" = 1 ]
  then
    if [ $# -eq 4 ]
    then
      setupApp "$(whoami)" "$2" "$3" "$4"
    elif [ $# -eq 3 ]
    then
      if [ "$2" = "y" ] || [ "$2" = "yes" ]
      then
        setupApp "$(whoami)" "$2"
      else
        echo "${warn}Local Database setup must contain DBUSER DBNAME arguments.${reset}"
      fi
    else
      echo "${warn}Wrong number of arguments.${reset}"
      echo "Usage: Step remoteDatabase? DBUSER DBNAME"
      echo "Example: 1 y fakktionDBUser fakktionDB"
      echo "Example: 1 n"
    fi
  elif [ "$1" = 2 ]
  then
    if [ $# -eq 2 ]
    then
      setupNGINX "$(whoami)" "$2"
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step SSLConfig? "
      echo "Example: 2 y/n "
    fi
  elif [ "$1" = 3 ]
  then
    if [ $# -eq 1 ]
    then
      prepareApp "$(whoami)"
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step"
      echo "Example: 3"
    fi
  fi
fi

