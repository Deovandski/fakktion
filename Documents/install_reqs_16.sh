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

# Set unique local secrets.yml
echo "" > config/secrets.yml
cat Documents/partial_secrets_16.txt >> config/secrets.yml
echo "  secret_key_base: $(rake secret)" >> config/secrets.yml

# Database SETUP
echo "A Postgres User with name $USER will now be created. Please enter the password for it, and don't forget to write it down!'"
sudo -u postgres createuser --superuser $USER --pwprompt
echo "Creating the fakktion database'"
sudo -u $USER createdb fakktion

# Move Fakktion to /var/www
mv /home/$USER/Fakktion /var/www

# Create necessary folders and files.
mkdir /var/www/Fakktion/tmp
mkdir /var/www/Fakktion/tmp/puma
touch /var/www/Fakktion/tmp/puma/pid
touch /var/www/Fakktion/tmp/puma/state
mkdir /var/www/Fakktion/shared
mkdir /var/www/Fakktion/shared/log
mkdir /var/www/Fakktion/shared/sockets
touch /var/www/Fakktion/shared/sockets/puma.sock
touch /var/www/Fakktion/shared/log/puma.stderr.log
touch /var/www/Fakktion/shared/log/puma.stdout.log

# Precompile App.
cd /var/www/Fakktion
rake assets:precompile

echo "Fakktion now lives under /var/www!"
cd /var/www/Fakktion/Documents
