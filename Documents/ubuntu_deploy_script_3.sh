#!/bin/bash
# TODO comments
echo ""> /etc/nginx/sites-available/default
cat Documents/fakktion.conf >> /etc/nginx/sites-available/default
sudo service nginx restart
