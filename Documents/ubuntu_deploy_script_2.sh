#!/bin/bash
# Overwrite NGINX configs.
echo ""> /etc/nginx/sites-available/default
cat /home/$USER/Fakktion/Documents/fakktion.conf >> /etc/nginx/sites-available/default
sudo service nginx restart
