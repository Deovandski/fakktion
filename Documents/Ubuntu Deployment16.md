## Ubuntu Server 16.04 Deployment
In order to deploy an ember-cli-rails project to Ubuntu Server 16.04, please follow the server deployment section.

## Server Overall Structure

#### Local DB
![](u16_localdb.png)

#### Remote DB
![](u16_remotedb.png)

# Server Deployment

### Deployment Notes
1. This guide is tailored for max performance on running only one app (and its workers) through PUMA while using one single install of Ruby 2.3 with Node.js through NPM (Node Package Manager.) If you plan for multiple apps, you must use RVM (Ruby Version Manager) or Rbenv alongside NVM (Node Version Manager.)
2. I do not recommend dropping usage of Bundler, or other package managers in favor of apt-get. You will face terrible consequences from non-available packages, micro-managing inter-dependencies to lack of edge versions and broken installs with no clear solution. **You have been warned, so do not contact me wondering what went wrong if you did not follow this piece of advise!**
3. This guide sets up the database under the same server. However, it is recommended that you create a separated Postgres Database and connect to it instead by changing the config/database.yml.

### Server Requirements
1. Server with at least 10GB free space.
2. PostgreSQL database installed if you are running the local version.
3. Encrypted home directory.
4. OpenSSH recommended

### Initial Deploy
1. Fork this project if you have not done so already!
2. Run ```sudo apt-get update``` followed by ```sudo apt-get upgrade```.
3. Install Git Core ```sudo apt-get install -y git-core```
4. From your home/$USER directory, clone repo through ```git clone https://github.com/YOURUSERNAME/Fakktion.git``` (HTTPS instead of SSH suggested as it will make it harder to accidentally push commits back into origin master (or the branch that you use as master.)
5. Navigate to Fakktion/Documents folder, and allow Execution access to the main script with ```sudo chmod +x u16deploy.sh```.
6. Now run ```./u16deploy.sh 1 USER``` (Or change $USER to the user where Puma will use to control the app. You must the same user whenever requested from now on.)
7. Run ```sudo reboot``` as a system restart is required. Upon restart, if the App has been created as another user, then you must login as said user for steps 8 and 9.
8. Now go into USER/Fakktion/config and execute ```sudo nano database.yml```, then change the **username** to DBUSER, **password** to DBPW, and **database** to DBNAME. You may need to change other configurations if setting up a remote database.
9. Navigate back to Documents folder, and execute ```. u16deploy.sh 2 RemoteDB? DBUSER DBNAME```. (replace RemoteDB? with y or n according to your demand for a local or remote DB. DBUSER and DBNAME are only necessary if setting up local database.)
10. Now login back as the previous user if you did switch accounts. The reason for this is because the app user was granted temporary sudo to install some initial dependencies that could not have worked non-sudo. However, this only applies to the initial install.
11. Execute ```sudo ./u16deploy.sh 3 USER``` to setup PUMA Daemon service through init.d.
12. If you need **SSL**, then open **fakktion_16_ssl.conf** and change the certificate details.
13. Execute ```sudo ./u16deploy.sh 4 USER SSL?``` (replace SSL? with y or n) to setup NGINX in order to put your app live.
14. ```sudo reboot```, then login as the app user.
15. Initiate Puma socket with the final part of the script: ```. u16deploy.sh 5```.
16. Visit your live website! Not working? Go to the **Checking Logs** section for more info.

### Troubleshooting Initial Deploy
1. **Ruby version installed is different from the one specified on gemfile.**
If this error happens, then go back to your development machine, and run ```sudo apt-get install -y libpq-dev nginx ruby2.3 rails bundler```. Then, fix the gemfile to the current installed ruby version and run ```rake test```. If all tests works, then push to master followed by pulling on the deployment server and retry the step.

2. **postgres user does not exist, or PostgreSQL related errors.**
Please fix them, or switch to a remote pg database before reattempting the step that failed.

# Maintenance/Advanced instructions (**WIP**)

### Updating Project Source Code without moving database or changing servers.
1. Make sure that the Admin notice was given in the website, and that users had at least 72 hours to deal with it.
2. Stop puma with "/etc/init.d/puma stop".
3. Run the backup script (**backup_script_16.sh**) to save the puma.rb, secrets.yml and database.yml.
4. Create a database dump as described on the [official Docs](http://www.postgresql.org/docs/9.1/static/backup.html) if you are making new Database migrations.
4. Pull the changes with ```git pull https://github.com/YOURUSERNAME/Fakktion.git```
5. Perform the necessary changes including any needed package manager updates.
6. Run the recover script (**recover_script_16.sh**) to restore the unique puma.rb, secrets.yml and database.yml
7. Start puma back with "/etc/init.d/puma restart".

### Updating Project Source Code with database changes or between Servers. (**WIP**)
Follow the instructions from the [official Docs](http://www.postgresql.org/docs/9.1/static/backup.html) before following the instructions from this guide. 

**DO NOT MOVE DATABASE WITH PENDING MIGRATIONS!** If you do have pending migrations, you must follow the normal updating guide before following this guide otherwise you will risk desync schemas! 

If performing a change of VM, copy the contents of the backup script stored under home/$USER/Fakktion_backup and the Postgres DB dump to the new machine without executing them, and follow the initial deploy guide with the following changes:

1. Use the recover script on step 8, and again right after step 9 (unless you are okay with changing the rake secret because it will force a logout of all clients.)
2. After step 9 recover the database with the instructions from the official docs.

### Checking Logs
1. Puma Cluster log available under app/log/puma.log
2. Puma Stdout and Puma Stdeer logs available under app/shared/log

### Check running PUMA apps
```ps aux | grep puma```

### Manually Running puma
```bundle exec puma -e production -d -b unix:///var/www/Fakktion/shared/sockets/puma.sock```

### Remove app from PUMA
```sudo /etc/init.d/puma remove /path/to/app```

