#!/bin/bash
# Create copy of Rake secrets and Database info.

mkdir /home/$USER/Fakktion_backup
cp /var/www/Fakktion/config/database.yml /home/$USER/Fakktion_backup
cp /var/www/Fakktion/config/secrets.yml /home/$USER/Fakktion_backup
echo "Finished copying database.yml and secrets.yml"
