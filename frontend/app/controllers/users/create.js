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
  gender: '',
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
    if(this.get('fullName').length < 1) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty';
    }
    else {
      this.set('clientSideValidationComplete',true);
      return '';
    }
  }),
  verifyDisplayName: Ember.computed('displayName', function() {
    if(this.get('displayName').length < 5) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty';
    }
    else {
      if(this.model.get('users').isAny('display_name', this.get('displayName'))) {
        this.set('clientSideValidationComplete',false);
        return 'This Display Name is already in use...';
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
      return "";
    }
    else {
      var currentAge = this.get('dateOfBirth_month') + '/' + this.get('dateOfBirth_day') + '/' + this.get('dateOfBirth_year');
      currentAge = moment(currentAge, 'MM/DD/YYY');
      if(moment(currentAge).format() === 'Invalid date') {
        console.log(currentAge);
        this.set('clientSideValidationComplete',false);
        this.set('dateOfBirth', null);
        return "Invalid Date...";
      }
      else {
        this.set('dateOfBirth', currentAge);
        this.set('clientSideValidationComplete',true);
      }
    }
  }),
  verifyDateOfBirth_month: Ember.computed('dateOfBirth_month',  function() {
    if(this.get('dateOfBirth_month') === null || this.get('dateOfBirth_month') === "") {
      this.set('validDate_month',false);
      return 'MM';
    }
    else {
      if(this.get('dateOfBirth_month') > 12){
        this.set('validDate_month',false);
        return 'MM';
      }
      else if(this.get('dateOfBirth_month') <= 12){
        this.set('validDate_month',true);
        return '';
      }
      else{
        this.set('validDate_month',false);
        return 'MM';
      }
    }
  }),
  verifyDateOfBirth_day: Ember.computed('dateOfBirth_day',  function() {
    if(this.get('dateOfBirth_day') === null || this.get('dateOfBirth_day') === "") {
      this.set('validDate_day',false);
      return 'DD';
    }
    else {
      if(this.get('dateOfBirth_day') > 31){
        this.set('validDate_day',false);
        return 'DD';
      }
      else if(this.get('dateOfBirth_day') <= 31){
        this.set('validDate_day',true);
        return '';
      }
      else{
        this.set('validDate_day',false);
        return 'DD';
      }
    }
  }),
  verifyDateOfBirth_year: Ember.computed('dateOfBirth_year',  function() {
    if(this.get('dateOfBirth_year') === null || this.get('dateOfBirth_year') === "") {
      this.set('validDate_year',false);
      return 'YYYY';
    }
    else if(this.get('dateOfBirth_year') < 1900) {
      this.set('validDate_year',false);
      return 'YYYY';
    }
    else {
      var minAge = moment().subtract(12,'y').format('YYYY');
      var currentAge = moment(this.get('dateOfBirth_year'), 'YYYY').format('YYYY');
      var dateComparison = minAge - currentAge;
      if(dateComparison < 0 && dateComparison > -12) {
        this.set('validDate_year',false);
        return 'You must be at least 13';
      }
      else if(dateComparison <= -12) {
        this.set('validDate_year',false);
        return 'Were you born in the future?';
      }
      else {
        this.set('validDate_year',true);
        return '';
      }
    }
  }),
  verifyEmail: Ember.computed('email', function() {
    if(this.get('email').length < 4) {
      this.set('clientSideValidationComplete',false);
      return 'user@sample.com';
    }
    else {
      var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
      if(emailRegex.test(this.get('email'))) {
        if(this.model.get('users').isAny('email', this.get('email'))) {
          this.set('clientSideValidationComplete',false);
          return 'This Email is already in use...';
        }
        else {
          this.set('clientSideValidationComplete',true);
          return '';
        }
      }
      else {
        this.set('clientSideValidationComplete',false);
        return 'Not a valid email';
      }
    }
  }),
  verifyPassword: Ember.computed('password', function() {
    if(this.get('password').length < 8) {
      this.set('clientSideValidationComplete',false);
      return 'Too Short';
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
  verifyGender: Ember.computed('gender', function() {
    //console.log(this.get('gender').toLowerCase());
    if(this.get('gender').toLowerCase() !== 'male' && this.get('gender').toLowerCase() !== 'female' && this.get('gender').toLowerCase() !== 'other')
      {return 'male/female/other';}
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
          gender: this.get('gender'),
          email: this.get('email'),
          password: this.get('password'),
          legal_terms_read: this.get('legalTermsRead'),
          privacy_terms_read: this.get('privacyTermsRead'),
          date_of_birth: moment(this.get('dateOfBirth')).toDate(),
          show_full_name: this.get('showFullName'),
          is_banned: false,
          is_admin: false
        });
        var self = this; // Controller instance for route transitioning.
        user.save().then(function() {
          self.transitionToRoute('login');
        }, function() {
          alert('(Server 402) failed to create User... Check your input and try again!');
        });
      }
      else {
        alert("(Client 402) Failed to create User... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
 
