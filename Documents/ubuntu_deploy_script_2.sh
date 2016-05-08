#!/bin/bash
# Overwrite NGINX configs.
echo "" > /etc/nginx/sites-available/default
cd /home/$USER/Fakktion/Documents
cat fakktion.conf >> /etc/nginx/sites-available/default
sudo service nginx restart
