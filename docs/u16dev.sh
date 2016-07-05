#!/bin/bash
# u16dev.sh v1
# Script for setting up development envivroment on Ubuntu 16.
# The entire guide can be found at http://deovandski.herokuapp.com/emberTutorial/installation

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

backendDependencies(){
  if [ "$2" = "y" ] || [ "$2" = "yes" ]
  then
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    watchForErrors $? "RVM Key" ""
    \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.1 --rails
    watchForErrors $? "RVM setup" ""
  else
    sudo apt-get install -y libpq-dev ruby2.3 rails bundler
    watchForErrors $? "Backend Dependencies install" ""
  fi

}
frontendDependencies(){
  sudo npm cache clean -f
  watchForErrors $? "Previous package cleanup" ""
  sudo npm install -g n
  watchForErrors $? "NODE N Package manageer install" ""
  sudo n stable
  watchForErrors $? "NODE install" ""
  sudo chown -R "$(whoami)" "$(npm config get prefix)"/{lib/node_modules,bin,share}
  watchForErrors $? "NPM Permissions fix" ""
  npm install ember-cli -g
  watchForErrors $? "Ember CLI install" ""
  npm install bower -g
  watchForErrors $? "Bower install" ""
  npm install phantomjs
  watchForErrors $? "Phantomjs install" ""
}

appDependencies(){
  cd ..
  bundle install
  watchForErrors $? "Bundler dependencies install" ""
  rake db:setup
  watchForErrors $? "Dev DB setup dependencies install" ""
  cd frontend || return
  npm install
  watchForErrors $? "NPM dependencies install" ""
  bower install
  watchForErrors $? "Bower dependencies install" ""
  cd ..
  if [ "$2" = "y" ] || [ "$2" = "yes" ]
  then
    wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
    watchForErrors $? "Heroku Toolbet" ""
  else
    echo "SKIPPED | Heroku Toolbet"
  fi
}

if [ $# -eq 0 ]
then
  echo "${warn}Incorrect # of arguments...${reset}"
  echo "1"
  echo "2 RVM?"
  echo "2 n"
  echo "3"
else
  if [ "$1" = 1 ]
  then
    if [ $# -eq 2 ]
    then
      backendDependencies "$2"
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step RVM?"
      echo "Example: 2 n"
    fi
  elif [ "$1" = 2 ]
  then
    if [ $# -eq 1 ]
    then
      frontendDependencies
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step"
      echo "Example: 1"
    fi
  elif [ "$1" = 3 ]
  then
    if [ $# -eq 2 ]
    then
      appDependencies "$2"
    else
      echo "${warn}Incorrect # of arguments...${reset}"
      echo "Usage: Step HerokuToolbet?"
      echo "Example: 2 n"
    fi
  fi
fi
