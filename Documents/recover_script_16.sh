#!/bin/bash
# Recover copy of Rake secrets and Database info.

cp -n /home/$USER/Fakktion_backup/database.yml /var/www/Fakktion/config/
cp -n /home/$USER/Fakktion_backup/secrets.yml /var/www/Fakktion/config/
rm -rf  /home/$USER/Fakktion_backup
echo "Finished copying database.yml and secrets.yml"
