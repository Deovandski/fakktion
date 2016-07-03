#!/bin/bash
# u14deploy.sh v1 - Deprecated Guide
# Ubuntu Server 14.04 deployment

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

setupBaseReqs(){
  # Min necessary for the next steps
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
}
setupApp(){
  # Install app wide dependencies.
  sudo apt-get install nginx libpq-dev
  cd /home/"$USER" || return
  sudo apt-get install npm
  sudo npm cache clean -f
  sudo npm install -g n
  sudo n stable
  sudo chown -R "$(whoami)" "$(npm config get prefix)"/{lib/node_modules,bin,share}
  cd /home/"$USER"/Fakktion || return
  bundle install
  cd frontend || return
  npm install
  npm install -g bower
  bower install
  cd ..

  # Puma configuration
  echo "" > config/puma.rb
  echo "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
  cat docs/source/partial_puma_14.txt >> config/puma.rb
  mkdir -p shared/pids shared/sockets shared/log
  cd ~ || return
  wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
  wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf

  # watchForErrors $? "Rake db migration and seeding" "run rake db:setup mannually"
}

setupNGINX(){
  # Overwrite NGINX configs. Ubuntu 14.04 Deployment.
  echo "" > /etc/nginx/sites-available/default
  cat source/fakktion_14.conf >> /etc/nginx/sites-available/default
  service nginx restart
  watchForErrors $? "NGINX restart" ""
}


if [ $# -eq 0 ]
then
  echo "${warn}Please check the guide...${reset}"
else    
  if [ "$1" = 1 ]
  then
    if [ $# -eq 2 ]
    then
      setupBaseReqs "$2"
    else
      echo "${warn}Wrong number of arguments for step 1${reset}"
    fi
  elif [ "$1" = 2 ]
  then
    if [ $# -eq 2 ]
    then
      setupApp "$2"
    else
      echo "${warn}Wrong number of arguments for step 2${reset}"
    fi
  elif [ "$1" = 3 ]
  then
    if [ $# -eq 2 ]
    then
      setupNGINX "$2"
    else
      echo "${warn}Wrong number of arguments for step 3${reset}"
    fi
  else
      echo "${warn}Please check the guides${reset}"
  fi
fi

