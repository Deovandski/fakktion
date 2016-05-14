#!/bin/bash
# Install app wide dependencies. Ubuntu 16 Deployment
cd /var/www/Fakktion # Make sure that we are in the proper place.
# Install NPM and NODE
sudo apt-get -y install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
# Fix Ownsership issues risen fro mthe use of sudo because non-sudo installs often lead to issues.
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
# Install all Fakktion frontend dependencies
cd frontend
npm install
npm install -g bower
bower install
cd ..

