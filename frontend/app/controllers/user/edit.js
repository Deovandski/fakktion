import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend ({
	session: service('session'),
	sessionAccount: service('session-account'),
	currentPassword: "",
	newPassword: "",
	newPasswordConfirmation: "",
	clientSideValidationComplete: false,
	showPassword: false,
	showExtra: false,
	verifyFullName: Ember.computed('model.user.full_name', function() {
		if(this.get('model.user.full_name').length < 1) {
			this.set("clientSideValidationComplete",false);
			return "Cannot be empty";
		}
		else {
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyDisplayName: Ember.computed('model.user.display_name', function() {
		if(this.get('model.user.display_name').length < 5) {
			this.set("clientSideValidationComplete",false);
			if(this.get('model.user.display_name').length !== 0) {
				return "Too few characters";
			}
			else {
				return "Cannot be empty";
			}
		}
		else {
			var possibleUser = this.get('model.users').filterBy('display_name', this.get('model.user.display_name'));
			if(possibleUser.length > 1) {
				this.set("clientSideValidationComplete",false);
				return "Another User has this display name!";
			}
			else {
				this.set("clientSideValidationComplete",true);
				return "";
			}
		}
	}),
	verifyDateOfBirth: Ember.computed('model.user.date_of_birth', function() {
		if(this.get('model.user.date_of_birth') === null) {
			this.set("clientSideValidationComplete",true);
		}
		else {
			if(this.get('model.user.date_of_birth') === '') {
				this.set('model.user.dateOfBirth', null);
				this.set("clientSideValidationComplete",true);
				return "";
			}
			else if(moment(this.get('model.user.date_of_birth')).format() === "Invalid date") {
				this.set("clientSideValidationComplete",false);
				return "MM/DD/YYYY";
			}
			else {
				var minAge = moment().subtract(12,'y');
				var maxAge = moment().subtract(200,'y');
				var currentAge = moment(this.get('model.user.date_of_birth'));
				if(minAge.diff(currentAge) < 0) {
					this.set("clientSideValidationComplete",false);
					return "You must be at least 13 to signup";
				}
				else if(maxAge.diff(currentAge) > 200) {
					this.set("clientSideValidationComplete",false);
					return moment(currentAge).format('LL') + " is more than 200 years";
				}
				else {
					this.set("clientSideValidationComplete",true);
					return "";
				}
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
				return "";
			}
			else {
				this.set("clientSideValidationComplete",false);
				return "Too Short";
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
				if(this.get('currentPassword').length !== 0) {
					this.set("clientSideValidationComplete",false);
					return "Cannot be left empty!";
				}
				else {
					this.set("clientSideValidationComplete",true);
					return "";
				}
			}
			else {
				this.set("clientSideValidationComplete",false);
				return "Too Short";
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
	verifyGender: Ember.computed('model.user.gender', function() {
		if(this.get('model.user.gender').toLowerCase() !== "male" && this.get('model.user.gender').toLowerCase() !== "female" && this.get('model.gender').toLowerCase() !== "other") {
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
			if(this.get('model.facebook_url').indexOf("facebook") !== -1) {
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
			if(this.get('model.user.twitter_url').indexOf("twitter") !== -1) {
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
			if(this.get('model.user.webpage_url').length < 10) {
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
			return "http://www.example.com https://www.example.com";
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
				/*if(this.get('model.user.dateOfBirth') !== null && this.get('model.user.dateOfBirth') !== '') {
					user.set('model.user.date_of_birth', moment(this.get('model.user.dateOfBirth')).toDate());
				}*/
				if(this.get('newPassword') !== null && this.get('newPassword') !== '') {
					user.set('password', this.get('newPassword'));
				}
				else {
					 //Identify Password as blank in order to trigger user.update_without_password(user_params)
					user.set('password', "");
				}
				if(this.get('currentPassword') !== null && this.get('currentPassword') !== '') {
					user.set('current_password', this.get('currentPassword'));
				}
				else {
					user.set('current_password', "");
				}
				user.save().then(() => {
					this.transitionToRoute('user', user);
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
 
