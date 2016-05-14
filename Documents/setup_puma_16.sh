# Copy the init script to services directory 
sudo cp puma /etc/init.d
sudo chmod +x /etc/init.d/puma

# Make it start at boot time. 
sudo update-rc.d -f puma defaults

# Copy the Puma runner to an accessible location
sudo cp run-puma /usr/local/bin
sudo chmod +x /usr/local/bin/run-puma

# Create an empty configuration file
sudo touch /etc/puma.conf

# Link Fakktion to Puma
sudo /etc/init.d/puma add /var/www/Fakktion root /var/www/Fakktion/config/puma.rb /var/www/Fakktion/log/puma.log

# Create necessary tmp folders.

sudo mkdir /var/www/Fakktion/tmp/puma
