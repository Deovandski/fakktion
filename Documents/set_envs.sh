#!/bin/bash
# Append ENVS
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
source ~/.rvm/scripts/rvm
gem install bundler

echo "SKB=\"$(rake secrets)\"" >> ~/.profile
echo "RAILS_ENV=production" >> ~/.profile
echo "FAKKTION_DATABASE_USER=\"$(rake secrets)\"" >> ~/.profile
echo "FAKKTION_DATABASE_PASSWORD=CHANGE_ME" >> ~/.profile
echo "FAKKTION_PRODUCTION_DATABASE=fakktion" >> ~/.profile
