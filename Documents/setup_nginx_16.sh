#!/bin/bash
# Overwrite NGINX configs. Ubuntu 16.04 Deployment.
echo "" > /etc/nginx/sites-available/default
# Change to the SSL version is you want to.
cat fakktion_16_non_ssl.conf >> /etc/nginx/sites-available/default
service nginx restart
echo "NGINX is ready!"
