# Ubuntu Server 16.04 Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server 16.04, please follow the initial deploy section.

Notes:

1. This guide is tailored for max performance on running only one app (and its workers) through PUMA while using one single install of Ruby 2.3 with Node.js through NPM (Node Package Manager.) If you plan for multiple apps, you must use RVM (Ruby Version Manager) or Rbenv alongside NVM (Node Version Manager.)

2. I do not recommend dropping usage of Bundler, or other package managers in favor of apt-get. You will face terrible consequences from non-available packages, micro-managing inter-dependencies to lack of edge versions and broken installs with no clear solution. **You have been warned, so do not contact me wondering what went wrong if you did not follow this piece of advise!**

3. At the end of the initial deploy, the minified Fakktion app will be roughly 110 MB (including dependencies, but excluding database). However, you will to need reserve at least 5 GB for the deploy process since this methodology is not the same as the one used on Heroku, Docker or Kubernetes pods...

4. All bash scripts used by the Ubuntu 16 deployment are fully documented.

5. **DO NOT USE THE SCRIPTS FOR UBUNTU 14 DEPLOYMENT!**

## Initial Deploy (**WIP**)
1. Fork this project if you have not done so already!
2. Run ```sudo apt-get update```.
3. Install Git Core ```sudo apt-get install -y git-core```
5. From your home/$USER directory, clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git``` (HTTPS instead of SSH suggested as it will make it harder to accidentally push commits back into origin master (or the branch that you use as master.)
6. Navigate to Fakktion/Documents folder, and execute ```. base_reqs_16.sh```.
7. Now reboot with ```sudo reboot```. This is needed because the previous script added you into the **www-data** group, and at the end PUMA will run the app through you. Logging out and then back in is not a recommend solution as the system will notify you that a restart is required.
8. ```nano config/database.yml``` and change the **username** to your $USER, **password** to an unique one, and database to **fakktion**. The next step will setup the database for you, but you will need to enter the password when requested.
9. Navigate back to Documents folder, and execute ```. install_reqs_16.sh```.
10. Edit **setup_puma_16.sh** with ```nano setup_puma_16.sh```, and change the user from **deovandski** to your user.
11. Execute ```sudo ./setup_puma_16.sh``` to setup PUMA Daemon service through init.d.
12. If you need **SSL**, then open **fakktion_16_ssl.conf**. Otherwise open **fakktion_16_non_ssl.conf**.
13. Change hostname on the conf file if desired. ALso, you will need to change the certificate details if using the SSL version.
14. Execute ```sudo ./setup_nginx_16.sh``` to setup NGINX in order to put your app live.
15. ```sudo reboot```, then visit your live website! Not working? Check the **Checking Logs** section for more info.


## Manually Running puma
```bundle exec puma -e production -d -b unix:///var/www/Fakktion/shared/sockets/puma.sock```

## Updating Project Source Code.
1. Make sure that the Admin notice was given in the website, and that users had at least 72 hours to deal with it.
2. Stop puma with "/etc/init.d/puma stop".
3. Run the backup script to save the puma.rb, secrets.yml and database.yml **(TODO)**
4. Pull the changes with ```git pull https://github.com/YOURUSERNAME/Fakktion.git```
5. Perform the necessary changes including any needed package manager updates.
6. Run the recover script to restore the unique puma.rb, secrets.yml and database.yml **(TODO)**
7. Start puma back with "/etc/init.d/puma restart".

## Checking Logs
1. Puma Cluster log available under app/log/puma.log
2. Puma Stdout and Puma Stdeer logs available under app/shared/log

## Check running PUMA apps
```ps aux | grep puma```

## Remove app from PUMA
```sudo /etc/init.d/puma remove /path/to/app```

