#!/bin/bash
# Overwrite NGINX configs. Ubuntu 14.04 Deployment.
echo "" > /etc/nginx/sites-available/default
cat fakktion_14.conf >> /etc/nginx/sites-available/default
service nginx restart
