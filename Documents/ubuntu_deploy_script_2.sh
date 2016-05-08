#!/bin/bash
# Overwrite NGINX configs.
sudo echo "" > /etc/nginx/sites-available/default
cd /home/$USER/Fakktion/Documents
sudo cat fakktion.conf >> /etc/nginx/sites-available/default
sudo service nginx restart
