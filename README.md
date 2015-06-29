# The Fakktion Blog Source Code

![](/FakktionLogo.png)

All information about this project can be found on this [published paper](http://www.micsymposium.org/mics2015/ProceedingsMICS_2015/Skibinski_3C1_31.pdf). Information regarding the Database Design and can be seen [Here](erd.pdf), and information about progress can be seen [Here](Documents/TODO.txt).

##Notice
This project once used [Ember-Rails](https://github.com/emberjs/ember-rails), but now it is using [Ember-cli-rails](https://github.com/rwz/ember-cli-rails). If you would like to see the previous Ember-Rails implementation, please check the [Ember-Rails Implementation branch](https://github.com/Deovandski/Fakktion/tree/Ember-Rails).

[Discussions regarding this project:](Documents/discussions.md)

## Building Project

1. Clone Project
2. Create new Secrets.yml and place it on the config folder. See Extra Commands on the root folder.
3. Bundle Install
4. Rake db:migrate
5. Rake db:seed
6. cd frontend
7. npm install
8. bower install
9. rake start and solve any remaining issues if there are any...
10. Login using user@example.com with password 12345678

##License

[The MIT License (MIT)](Documents/LICENSE.md)

Copyright (c) 2014 - 2015, Deovandski Skibinski Junior and Dr. Anne Denton
All rights reserved.
