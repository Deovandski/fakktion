#!/bin/bash
# TODO comments
cd /home/$USER/Fakktion
> config/puma.rb
cat "workers $(grep -c processor /proc/cpuinfo)" >> config/puma.rb
cat Documents/partial_puma.txt >> config/puma.rb
mkdir -p shared/pids shared/sockets shared/log
cd ~
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf
