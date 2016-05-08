#!/bin/bash
# Overwrite NGINX configs.
echo "" > /etc/nginx/sites-available/default
cat fakktion.conf >> /etc/nginx/sites-available/default
service nginx restart
