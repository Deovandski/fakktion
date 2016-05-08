#!/bin/bash
# Append ENVS
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
source ~/.rvm/scripts/rvm
gem install bundler

cat 'SKB="$(rake secret)"' >> ~/.profile
cat 'RAILS_ENV="production"' >> ~/.profile
cat 'FAKKTION_DATABASE_USER="$USER"' >> ~/.profile
cat 'FAKKTION_DATABASE_PASSWORD="CHANGE_ME"' >> ~/.profile
cat 'FAKKTION_PRODUCTION_DATABASE="fakktion"' >> ~/.profile
