#!/bin/bash
# Install app wide dependencies. Ubuntu 16 Deployment

# Make sure that we are in the proper place.
cd /home/$USER/Fakktion

# Install NPM (Node.js Package Manager) followed by installing Node.js
# The install methodology below avoids the use of NVM (node version manager.)
sudo apt-get -y install npm
sudo npm cache clean -f
# n package | https://www.npmjs.com/package/n
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
