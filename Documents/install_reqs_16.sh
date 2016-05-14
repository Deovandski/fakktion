#!/bin/bash
# Install app wide dependencies. Ubuntu 16 Deployment
cd /home/$USER/Fakktion # Make sure that we are in the proper place.
# Install NPM and NODE
sudo apt-get -y install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
# Fix ownership issues risen from the use of sudo because non-sudo installs often lead to issues.
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
# Install all Fakktion frontend dependencies
cd frontend
# NPM install takes care of Ember CLI Middleware
npm install
# Bower takes care of Ember.js (Ember.js !== Ember CLI)
npm install -g bower
bower install
cd ..

