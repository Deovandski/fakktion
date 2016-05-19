# Ubuntu Server 16.04 Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server 16.04, please follow the initial deploy section.

Notes:

1. This guide is tailored for max performance on running only one app (and its workers) through PUMA while using one single install of Ruby 2.3 with Node.js through NPM (Node Package Manager.) If you plan for multiple apps, you must use RVM (Ruby Version Manager) or Rbenv alongside NVM (Node Version Manager.)

2. I do not recommend dropping usage of Bundler, or other package managers in favor of apt-get. You will face terrible consequences from non-available packages, micro-managing inter-dependencies to lack of edge versions and broken installs with no clear solution. **You have been warned, so do not contact me wondering what went wrong if you did not follow this piece of advise!**

3. At the end of the initial deploy, the minified Fakktion app will be roughly 110 MB (including dependencies, but excluding database). However, you will to need reserve at least 5 GB for the deploy process since this methodology is not the same as the one used on Heroku, Docker or Kubernetes pods...

4. All bash scripts used by the Ubuntu 16 deployment are fully documented.

5. **DO NOT USE THE SCRIPTS FOR UBUNTU 14 DEPLOYMENT!**

## Initial Deploy
1. Fork this project if you have not done so already!
2. Run ```sudo apt-get update```.
3. Install Git Core ```sudo apt-get install -y git-core```
5. From your home/$USER directory, clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git``` (HTTPS instead of SSH suggested as it will make it harder to accidentally push commits back into origin master (or the branch that you use as master.)
6. Navigate to Fakktion/Documents folder, and execute ```. base_reqs_16.sh```.
7. Now reboot with ```sudo reboot```. This is needed because the previous script added you into the **www-data** group, and at the end PUMA will run the app through you. Logging out and then back in is not a recommend solution as the system will notify you that a restart is required.
8. After the restart, go into Fakktion/config and execute ```nano database.yml```, then change the **username** to your $USER, **password** to an unique one, and database to **fakktion**. The next step will setup the database for you, but you will need to enter the password when requested.
9. Navigate back to Documents folder, and execute ```. install_reqs_16.sh```.
10. Edit **setup_puma_16.sh** with ```nano setup_puma_16.sh```, and change the user from **deovandski** to your user.
11. Execute ```sudo ./setup_puma_16.sh``` to setup PUMA Daemon service through init.d.
12. If you need **SSL**, then open **fakktion_16_ssl.conf**. Otherwise open **fakktion_16_non_ssl.conf**.
13. Change hostname on the conf file if desired. ALso, you will need to change the certificate details if using the SSL version.
14. Execute ```sudo ./setup_nginx_16.sh``` to setup NGINX in order to put your app live.
15. ```sudo reboot```.
16. Now mannually run Fakktion with ```bundle exec puma -e production -d -b unix:///var/www/Fakktion/shared/sockets/puma.sock```. This command is needed only once!
17. Visit your live website! Not working? Check the **Checking Logs** section for more info.

## Updating Project Source Code without moving database or changing VMs.
1. Make sure that the Admin notice was given in the website, and that users had at least 72 hours to deal with it.
2. Stop puma with "/etc/init.d/puma stop".
3. Run the backup script (**backup_script_16.sh**) to save the puma.rb, secrets.yml and database.yml.
4. Create a database dump as described on the [official Docs](http://www.postgresql.org/docs/9.1/static/backup.html) if you are making new Database migrations.
4. Pull the changes with ```git pull https://github.com/YOURUSERNAME/Fakktion.git```
5. Perform the necessary changes including any needed package manager updates.
6. Run the recover script (**recover_script_16.sh**) to restore the unique puma.rb, secrets.yml and database.yml **(TODO)**
7. Start puma back with "/etc/init.d/puma restart".

## Updating Project Source Code with database changes or between VMs.
Follow the instructions from the [official Docs](http://www.postgresql.org/docs/9.1/static/backup.html) before following the instructions from this guide. 

**DO NOT MOVE DATABASE WITH PENDING MIGRATIONS!** If you do have pending migrations, you must follow the normal updating guide before following this guide otherwise you will risk desync schemas! 

If performing a change of VM, copy the contents of the backup script stored under home/$USER/Fakktion_backup and the Postgres DB dump to the new machine without executing them, and follow the initial deploy guide with the following changes:

1. Use the recover script on step 8, and again right after step 9 (unless you are okay with changing the rake secret because it will force a logout of all clients.)
2. After step 9 recover the database with the instructions from the official docs.

# Maintenance/Advanced instructions

## Checking Logs
1. Puma Cluster log available under app/log/puma.log
2. Puma Stdout and Puma Stdeer logs available under app/shared/log

## Check running PUMA apps
```ps aux | grep puma```

## Manually Running puma
```bundle exec puma -e production -d -b unix:///var/www/Fakktion/shared/sockets/puma.sock```

## Remove app from PUMA
```sudo /etc/init.d/puma remove /path/to/app```

