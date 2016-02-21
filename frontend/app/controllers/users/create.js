import Ember from 'ember';
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend ({
	fullName: '',
	displayName: '',
	email: '',
	password: '',
	passwordConfirmation: '',
	gender: '',
	legalTermsRead: false,
	privacyTermsRead: false,
	dateOfBirth: null,
	showFullName: false,
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
	verifyDateOfBirth: Ember.computed('dateOfBirth',  function() {
		if(this.get('dateOfBirth') === null) {
			this.set('clientSideValidationComplete',false);
			return 'MM/DD/YYYY';
		}
		else {
			if(moment(this.get('dateOfBirth')).format() === 'Invalid date') {
				this.set('clientSideValidationComplete',false);
				return 'Date must be Month/Day/Year';
			}
			else {
				var minAge = moment().subtract(12,'y');
				var maxAge = moment().subtract(200,'y');
				var currentAge = moment(this.get('dateOfBirth'));
				//console.log(minAge.diff(currentAge,'years'));
				if(minAge.diff(currentAge) < 0) {
					this.set('clientSideValidationComplete',false);
					return 'You must be at least 13 to signup';
				}
				else if(maxAge.diff(currentAge) > 200) {
					this.set('clientSideValidationComplete',false);
					return moment(currentAge).format('LL') + ' is more than 200 years';
				}
				else {
					this.set('clientSideValidationComplete',true);
					return '';
				}
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
					is_admin: false,
					is_super_user: false,
				});
				var self = this;
				user.save().then(function() {
				console.log('user created!');
				self.transitionToRoute('user', user);
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
 
