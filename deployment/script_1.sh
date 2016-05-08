#!/bin/bash
# TODO comments
sudo -u postgres createuser --superuser FAKKTION_DATABASE_USER
sudo -u FAKKTION_DATABASE_USER createdb FAKKTION_PRODUCTION_DATABASE
sudo apt-get install nginx git-core libpq-dev
cd /home/$USER
git clone https://github.com/Deovandski/Fakktion.git
sudo mv /home/user/Fakktion /var/www
sudo apt-get install npm
sudo npm cache clean -f
sudo npm install -g n
sudo n stable
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
source ~/.rvm/scripts/rvm
gem install bundler
cd /var/www/Fakktion
bundle install
cd frontend
npm install
bower install
cd ..
