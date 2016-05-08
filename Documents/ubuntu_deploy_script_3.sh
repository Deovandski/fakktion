#!/bin/bash
# TODO comments
>> /etc/nginx/sites-available/default
cat Documents/fakktion.conf >> /etc/nginx/sites-available/default
sudo service nginx restart
