#!/bin/bash
# Create Default ENV VARS
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
source ~/.rvm/scripts/rvm
gem install bundler

sudo echo "SECRET_KEY_BASE=\"$(rake secret)\"" >> /etc/default/locale
sudo echo "RAILS_ENV=\"production\"" >> /etc/default/locale
sudo echo "FAKKTION_DATABASE_USER=\"$USER\"" >> /etc/default/locale
sudo echo "FAKKTION_DATABASE_PASSWORD=\"CHANGE_ME\"" >> /etc/default/locale
sudo echo "FAKKTION_PRODUCTION_DATABASE=\"fakktion\"" >> /etc/default/locale
