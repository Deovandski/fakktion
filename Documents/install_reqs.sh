#!/bin/bash
# Script 1 taks care of creating the Postgres necessary stuff while also installing app wide dependencies.
sudo -u postgres createuser --superuser $FAKKTION_DATABASE_USER --pwprompt
sudo -u $FAKKTION_DATABASE_USER createdb $FAKKTION_PRODUCTION_DATABASE
gem install bundler
sudo apt-get install nginx libpq-dev
cd /home/$USER
sudo apt-get install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
cd /home/$USER/Fakktion
bundle install
cd frontend
npm install
npm install -g bower
bower install
cd ..

# Puma configuration
echo "" > config/puma.rb
echo "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
cat Documents/partial_puma.txt >> config/puma.rb
mkdir -p shared/pids shared/sockets shared/log
cd ~
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf
