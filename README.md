# The Fakktion Blog Source Code

![](/FakktionLogo.png)

The Ember-Rails branch is now deprecated. However, most of the code contained within was refactored to Ember 1.13 which is a step away from Ember.js 2.0

This project contains Active Model serializers, JSON API and Ember.js async models fetching and filtering while containing a Rails backend.

The purpose of this branch is for people who wants to see the code tied to the following discussions:

[June 21 2015 - Ember.js Discuss (ember.js 1.13 nothing displayed on each even though I can see it on the ember inspector)](http://discuss.emberjs.com/t/ember-js-1-13-nothing-displayed-on-each-even-though-i-can-see-it-on-the-ember-inspector/8237/2)

[June 22 2015 - Refactoring Computed Properties on Ember.js 1.13](http://stackoverflow.com/questions/30977856/refactoring-computed-properties-on-ember-js-1-13)

# Building Project
1. Clone Project
2. Create new Secrets.yml and place it on the config folder. See Extra Commands on the root folder.
3. Bundle Install
4. Rake db:migrate
5. Rake db:seed
6. rake start and enjoy!

This Project was last tested on June 2015.
