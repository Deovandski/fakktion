import Ember from 'ember';
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  fullName: '',
  displayName: '',
  email: '',
  password: '',
  passwordConfirmation: '',
  year_issue: "",
  legalTermsRead: false,
  privacyTermsRead: false,
  showFullName: false,
  dateOfBirth: null,
  dateOfBirth_day: null,
  dateOfBirth_month: null,
  dateOfBirth_year: null,
  validDate_month: false,
  validDate_day: false,
  validDate_year: false,
  clientSideValidationComplete: false,
  
  verifyFullName: Ember.computed('fullName', function() {
    if(this.get('fullName').length === 0) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty';
    }
    else if(this.get('fullName').length < 5) {
      this.set('clientSideValidationComplete',false);
      return 'Min 5 Chars.';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyDisplayName: Ember.computed('displayName', function() {
    if(this.get('displayName').length === 0) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty';
    }
    else if(this.get('displayName').length < 5) {
      this.set('clientSideValidationComplete',false);
      return 'Min 5 Chars.';
    }
    else {
      if(this.model.get('users').isAny('display_name', this.get('displayName'))) {
        this.set('clientSideValidationComplete',false);
        return 'This Display Name already exists...';
      }
      else {
        this.set('clientSideValidationComplete',true);
        return '';
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
        this.set('dateOfBirth', currentAge);
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
  verifyEmail: Ember.computed('email', function() {
    if(this.get('email').length === 0) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty.';
    }
    else {
      var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
      if(emailRegex.test(this.get('email'))) {
        if(this.model.get('users').isAny('email', this.get('email'))) {
          this.set('clientSideValidationComplete',false);
          return 'This Email already exists...';
        }
        else {
          this.set('clientSideValidationComplete',true);
          return '';
        }
      }
      else {
        this.set('clientSideValidationComplete',false);
        return 'Not Valid (user@sample.com)';
      }
    }
  }),
  verifyPassword: Ember.computed('password', function() {
    if(this.get('password').length < 8) {
      this.set('clientSideValidationComplete',false);
      return 'Min 8 chars.';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyPasswordConfirmation: Ember.computed('passwordConfirmation', 'password', function() {
    if(this.get('passwordConfirmation') !== this.get('password')) {
      this.set('clientSideValidationComplete',false);
      return 'Does not match!';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyShowFullName: Ember.computed('showFullName', function() {
    if(this.get('showFullName') !== true) {
      return '';
    }
    else {
      return '';
    }
  }),
  verifyLegalTermsRead: Ember.computed('legalTermsRead', function() {
    if(this.get('legalTermsRead') !== true) {
      this.set('clientSideValidationComplete',false);
      return 'Must Accept';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyPrivacyTermsRead: Ember.computed('privacyTermsRead', function() {
    if(this.get('privacyTermsRead') !== true) {
      this.set('clientSideValidationComplete',false);
      return 'Must Accept';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  actions: {
    create: function() {
      if(this.get('clientSideValidationComplete') === true) {
        var user = this.store.createRecord('user', {
          full_name: this.get('fullName'),
          display_name: this.get('displayName'),
          email: this.get('email'),
          password: this.get('password'),
          legal_terms_read: this.get('legalTermsRead'),
          privacy_terms_read: this.get('privacyTermsRead'),
          date_of_birth: moment(this.get('dateOfBirth')).toDate(),
          show_full_name: this.get('showFullName'),
          reputation: 0,
          is_super_user: false,
          is_admin: false,
          is_legend: false
        });
        var self = this; // Controller instance for route transitioning.
        user.save().then(function() {
          self.set('fullName','');
          self.set('displayName','');
          self.set('email','');
          self.set('password','');
          self.set('passwordConfirmation','');
          self.set('legal_terms_read',false);
          self.set('privacy_terms_read',false);
          self.set('show_full_name',false);
          self.set('dateOfBirth','');
          self.set('dateOfBirth_day','');
          self.set('dateOfBirth_month','');
          self.set('dateOfBirth_year','');
          self.transitionToRoute('login');
        }, function() {
          alert('Server Failure!');
        });
      }
      else {
        alert("Check any warning messages and try again! (Client Validation F)");
      }
    }
  }
});
 
