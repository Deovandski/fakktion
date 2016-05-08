#!/bin/bash
# Overwrite NGINX configs.
sudo echo "" > /etc/nginx/sites-available/default
sudo cat fakktion.conf >> /etc/nginx/sites-available/default
sudo service nginx restart
