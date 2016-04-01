import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;
/*
 * TO HANDLE: When the current_password is invalid, Server replies InvalidError
 * with the message below:
 * "The adapter rejected the commit because it was invalid"
*/
export default Ember.Controller.extend ({
  application: Ember.inject.controller('application'),
  session: service('session'),
  sessionAccount: service('session-account'),
  currentPassword: "",
  newPassword: "",
  newPasswordConfirmation: "",
  dateOfBirth: null,
  validDate_month: false,
  validDate_day: false,
  validDate_year: false,
  clientSideValidationComplete: false,
  showPassword: false,
  showExtra: false,
  verifyFullName: Ember.computed('model.user.full_name', function() {
    if(this.get('model.user.full_name').length === 0) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty';
    }
    else if(this.get('model.user.full_name').length < 5) {
      this.set('clientSideValidationComplete',false);
      return 'Min 5 Chars.';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyDisplayName: Ember.computed('model.user.display_name', function() {
    if(this.get('model.user.display_name').length < 5) {
      this.set("clientSideValidationComplete",false);
      if(this.get('model.user.display_name').length !== 0) {
        return "Min 5 Chars.";
      }
      else {
        return "Cannot be empty";
      }
    }
    else {
      // TODO = Change logic to check display names that were returned instead of the length?
      var possibleUser = this.get('model.users').filterBy('display_name', this.get('model.user.display_name'));
      if(possibleUser.length > 1) {
        this.set("clientSideValidationComplete",false);
        return "This Display name already exists!";
      }
      else {
        this.set("clientSideValidationComplete",true);
        return "";
      }
    }
  }),
  verifyDateOfBirth: Ember.computed('validDate_month', 'validDate_day', 'validDate_year', 'dateOfBirth_month', 'dateOfBirth_day','dateOfBirth_year',  function() {
    if(this.get('validDate_month') === false || this.get('validDate_day') === false || this.get('validDate_year') === false) {
      this.set('clientSideValidationComplete',false);
      this.set('dateOfBirth', null);
      if(this.get('year_issue') !== ""){
        return this.get('year_issue');
      }
      else {
        return 'MM/DD/YYYY';
      }
    }
    else {
      var currentAge = this.get('dateOfBirth_month') + '/' + this.get('dateOfBirth_day') + '/' + this.get('dateOfBirth_year');
      currentAge = moment(currentAge, 'MM/DD/YYYY');
      if(moment(currentAge).format() === 'Invalid date') {
        this.set('clientSideValidationComplete',false);
        this.set('dateOfBirth', null);
        return "MM/DD/YYYY";
      }
      else {
        this.set('dateOfBirth', currentAge.toDate());
        this.set('clientSideValidationComplete',true);
        return "";
      }
    }
  }),
  verifyDateOfBirth_month: Ember.computed('dateOfBirth_month',  function() {
    if(this.get('dateOfBirth_month') === null || this.get('dateOfBirth_month') === "") {
      this.set('validDate_month',false);
    }
    else {
      if(this.get('dateOfBirth_month') > 12){
        this.set('validDate_month',false);
      }
      else if(this.get('dateOfBirth_month') <= 12){
        this.set('validDate_month',true);
      }
      else{
        this.set('validDate_month',false);
      }
    }
  }),
  verifyDateOfBirth_day: Ember.computed('dateOfBirth_day',  function() {
    if(this.get('dateOfBirth_day') === null || this.get('dateOfBirth_day') === "") {
      this.set('validDate_day',false);
    }
    else {
      if(this.get('dateOfBirth_day') > 31){
        this.set('validDate_day',false);
      }
      else if(this.get('dateOfBirth_day') <= 31){
        this.set('validDate_day',true);
      }
      else{
        this.set('validDate_day',false);
      }
    }
  }),
  verifyDateOfBirth_year: Ember.computed('dateOfBirth_year',  function() {
    if(this.get('dateOfBirth_year') === null || this.get('dateOfBirth_year') === "") {
      this.set('validDate_year',false);
      this.set('year_issue', '');
    }
    else if(this.get('dateOfBirth_year').length <= 3) {
      this.set('validDate_year',false);
      this.set('year_issue', '');
    }
    else if(this.get('dateOfBirth_year') <= 1900) {
      this.set('validDate_year',false);
        this.set('year_issue', 'Born before 1900? Really?');
    }
    else {
      var minAge = moment().subtract(12,'y').format('YYYY');
      var currentAge = moment(this.get('dateOfBirth_year'), 'YYYY').format('YYYY');
      var dateComparison = minAge - currentAge;
      if(dateComparison < 0 && dateComparison > -12) {
        this.set('validDate_year',false);
        this.set('year_issue', 'Must be at least 13');
      }
      else if(dateComparison <= -12) {
        this.set('validDate_year',false);
        this.set('year_issue', 'Were you born in the future?');
      }
      else {
        this.set('validDate_year',true);
        this.set('year_issue', '');
      }
    }
  }),
  verifyEmail: Ember.computed('model.user.email', function() {
    if(this.get('model.user.email').length < 4) {
      this.set("clientSideValidationComplete",false);
      return "user@sample.com";
    }
    else {
      var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
      if(emailRegex.test(this.get('model.user.email'))) {
        var possibleUser = this.get('model.users').filterBy('email', this.get('model.user.email'));
        if(possibleUser.length > 1) {
          this.set("clientSideValidationComplete",false);
          return "Another user has this email!";
        }
        else {
          this.set("clientSideValidationComplete",true);
          return "";
        }
      }
      else {
        this.set("clientSideValidationComplete",false);
        return "Not a valid email";
      }
    }
  }),
  verifyCurrentPassword: Ember.computed('currentPassword', function() {
    if(this.get('currentPassword').length < 8) {
      if(this.get('currentPassword').length === 0) {
        this.set("clientSideValidationComplete",true);
        return "Please enter your password!";
      }
      else {
        this.set("clientSideValidationComplete",false);
        return "8 characters minimum.";
      }
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "";
    }
  }),
  verifyNewPassword: Ember.computed('newPassword', 'currentPassword', function() {
    if(this.get('newPassword').length < 8) {
      if(this.get('newPassword').length === 0) {
        this.set("clientSideValidationComplete",true);
        return "";
      }
      else {
        this.set("clientSideValidationComplete",false);
        return "8 characters minimum.";
      }
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "";
    }
  }),
  verifyNewPasswordConfirmation: Ember.computed('newPasswordConfirmation', 'newPassword', function() {
    if(this.get('newPasswordConfirmation') !== this.get('newPassword')) {
      this.set("clientSideValidationComplete",false);
      return "Does not match!";
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "";
    }
  }),
  current_password_check: Ember.computed('currentPassword', function() {
    if(this.get('currentPassword').length > 0) {
      return false;
    }
    else {
      return true;
    }
  }),
  verifyGender: Ember.computed('model.user.gender', function() {
    var inputText = this.get('model.user.gender').toLowerCase();
    if( inputText !== "male" && inputText !== "female" && inputText !== "other") {
      this.set("clientSideValidationComplete",false);
      return "male/female/other";
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "";
    }
  }),
  verifyFacebookURL: Ember.computed('model.user.facebook_url', function() {
    if(this.get('model.user.facebook_url') !== '') {
      if(this.get('model.user.facebook_url').indexOf("https://www.facebook.com") !== -1) {
        this.set("clientSideValidationComplete", true);
        return "";
      }
      else {
        this.set("clientSideValidationComplete", false);
        return "Invalid Facebook URL";
      }
    }
    else {
      this.set("clientSideValidationComplete", true);
      return "https://www.facebook.com/example";
    }
  }),
  verifyTwitterURL: Ember.computed('model.user.twitter_url', function() {
    if(this.get('model.user.twitter_url') !== '') {
      if(this.get('model.user.twitter_url').indexOf("https://twitter.com") !== -1) {
        this.set("clientSideValidationComplete", true);
        return "";
      }
      else {
        this.set("clientSideValidationComplete", false);
        return "Invalid Twitter URL";
      }
    }
    else {
      this.set("clientSideValidationComplete", true);
      return "https://twitter.com/example";
    }
  }),
  verifyWebpageURL: Ember.computed('model.user.webpage_url', function() {
    
    if(this.get('model.user.webpage_url') !== '') {
      if(this.get('model.user.webpage_url').length < 8) {
        this.set("clientSideValidationComplete", false);
        return "Invalid URL";
      }
      else {
        this.set("clientSideValidationComplete", true);
        return "";
      }
    }
    else {
      this.set("clientSideValidationComplete",true);
      return "http(s)://www.example.com";
    }
  }),
  verifyShowFullName: Ember.computed('model.user.show_full_name', function() {
    if(this.get('model.user.show_full_name') !== true) {
      return "";
    }
    else {
      return "";
    }
  }),
  actions: {
    setShowPassword: function(password) {
      this.set('showPassword', password);
    },
    setExtraPassword: function(extra) {
      this.set('showExtra', extra);
    },
    update: function(user) {
      if(this.get('clientSideValidationComplete')) {
        var reloadSession = null;
        var self = this; // Controller instance for route transitioning.
        if(this.get('newPassword') !== null && this.get('newPassword') !== '') {
          user.set('password', this.get('newPassword'));
        }
        else {
           //Identify Password as blank in order to trigger user.update_without_password(user_params)
          user.set('password', null);
        }
        if(this.get('currentPassword') !== null && this.get('currentPassword') !== '') {
          user.set('current_password', this.get('currentPassword'));
          reloadSession = true;
        }
        else {
          user.set('current_password', null);
          reloadSession = false;
        }
        if (this.get('model.user.date_of_birth') !== this.get('dateOfBirth')){
          user.set('date_of_birth', this.get('dateOfBirth'));
        }
        user.save().then(() => {
          self.set('currentPassword', "");
          self.set('newPassword', "");
          self.set('newPasswordConfirmation', "");
          if (reloadSession === true) {
            self.get('session').invalidate();
          }
          else {
            self.transitionToRoute('user', user);
          }
        }).catch((reason) => {
          console.log(reason);
          alert('User Not Updated!');
        });
      }
      else {
        alert("Failed to save user... Check the warning messages and try again!");
      }
    }
  }
});
 
