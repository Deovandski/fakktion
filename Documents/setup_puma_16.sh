# Copy the init script to services directory 
cp puma /etc/init.d
chmod +x /etc/init.d/puma

# Make it start at boot time. 
update-rc.d -f puma defaults

# Copy the Puma runner to an accessible location
cp run-puma /usr/local/bin
chmod +x /usr/local/bin/run-puma

# Create an empty configuration file
touch /etc/puma.conf

# Create necessary folders and files.
mkdir /var/www/Fakktion/tmp/puma
mkdir /var/www/Fakktion/shared
mkdir /var/www/Fakktion/shared/log
mkdir /var/www/Fakktion/shared/sockets
touch /var/www/Fakktion/shared/sockets/puma.sock
touch /var/www/Fakktion/shared/log/puma.stderr.log
touch /var/www/Fakktion/shared/log/puma.stdout.log

# Link Fakktion to Puma
/etc/init.d/puma add /var/www/Fakktion deovandski /var/www/Fakktion/config/puma.rb /var/www/Fakktion/log/puma.log

