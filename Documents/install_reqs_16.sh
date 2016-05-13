#!/bin/bash
# Install app wide dependencies. Ubuntu 16 Deployment
cd /var/www/Fakktion
sudo apt-get -y install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
cd frontend
npm install
npm install -g bower
bower install
cd ..

# Puma configuration
echo "" > config/puma.rb
echo "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
cat Documents/partial_puma_14.txt >> config/puma.rb
mkdir -p shared/pids shared/sockets shared/log
cd ~
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf
