import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	newPassword: "",
	newPasswordConfirmation: "",
	dateOfBirth: null,
	clientSideValidationComplete: false,
	verifyFullName: Ember.computed('model.full_name', function()
	{
		if(this.get('model.full_name').length < 1)
		{
			this.set("clientSideValidationComplete",false);
			return "Cannot be empty";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyDisplayName: Ember.computed('model.display_name', function()
	{
		if(this.get('model.display_name').length < 5)
		{
			this.set("clientSideValidationComplete",false);
			if(this.get('model.display_name').length !== 0)
			{
				return "Too few characters";
			}
			else
			{
				return "Cannot be empty";
			}
		}
		else
		{
			var possibleUser = this.get('users').filterBy('display_name', this.get('model.display_name'));
			if(possibleUser.length > 1)
			{
				this.set("clientSideValidationComplete",false);
				return "Another User has this display name!";
			}
			else
			{
				this.set("clientSideValidationComplete",true);
				return "";
			}
		}
	}),
	verifyDateOfBirth: Ember.computed('dateOfBirth', function()
	{
		if(this.get('dateOfBirth') === null)
		{
			this.set("clientSideValidationComplete",true);
		}
		else
		{
			if(this.get('dateOfBirth') === '')
			{
				this.set('dateOfBirth', null);
				this.set("clientSideValidationComplete",true);
				return "";
			}
			else if(moment(this.get('dateOfBirth')).format() === "Invalid date")
			{
				this.set("clientSideValidationComplete",false);
				return "MM/DD/YYYY";
			}
			else
			{
				var minAge = moment().subtract(12,'y');
				var maxAge = moment().subtract(200,'y');
				var currentAge = moment(this.get('dateOfBirth'));
				if(minAge.diff(currentAge) < 0)
				{
					this.set("clientSideValidationComplete",false);
					return "You must be at least 13 to signup";
				}
				else if(maxAge.diff(currentAge) > 200)
				{
					this.set("clientSideValidationComplete",false);
					return moment(currentAge).format('LL') + " is more than 200 years";
				}
				else
				{
					this.set("clientSideValidationComplete",true);
					return "";
				}
			}
		}	
	}),
	verifyEmail: Ember.computed('model.email', function()
	{
		if(this.get('model.email').length < 4)
		{
			this.set("clientSideValidationComplete",false);
			return "user@sample.com";
		}
		else
		{
			var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
			if(emailRegex.test(this.get('model.email')))
			{
				var possibleUser = this.get('users').filterBy('email', this.get('model.email'));
				if(possibleUser.length > 1)
				{
					this.set("clientSideValidationComplete",false);
					return "Another user has this email!";
				}
				else
				{
					this.set("clientSideValidationComplete",true);
					return "";
				}
			}
			else
			{
				this.set("clientSideValidationComplete",false);
				return "Not a valid email";
			}
		}
	}),
	verifyNewPassword: Ember.computed('newPassword', function()
	{
		if(this.get('newPassword').length < 8)
		{
			this.set("clientSideValidationComplete",false);
			return "Too Short";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyNewPasswordConfirmation: Ember.computed('newPasswordConfirmation', 'newPassword', function()
	{
		if(this.get('newPasswordConfirmation') !== this.get('newPassword'))
		{
			this.set("clientSideValidationComplete",false);
			return "Does not match!";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyGender: Ember.computed('model.gender', function()
	{
		if(this.get('model.gender').toLowerCase() !== "male" && this.get('model.gender').toLowerCase() !== "female" && this.get('model.gender').toLowerCase() !== "other")
			{return "male/female/other";}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyFacebookURL: Ember.computed('model.facebookURL', function()
	{
		if(this.get('model.facebookURL').length < 4)
		{
			this.set("clientSideValidationComplete",false);
			return "Paste complete URL";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyTwitterURL: Ember.computed('model.twitterURL', function()
	{
		if(this.get('model.twitterURL').length < 4)
		{
			this.set("clientSideValidationComplete",false);
			return "Paste complete URL";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyWebpageURL: Ember.computed('model.webpageURL', function()
	{
		if(this.get('model.webpageURL').length < 4)
		{
			this.set("clientSideValidationComplete",false);
			return "Paste complete URL";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyShowFullName: Ember.computed('model.showFullName', function()
	{
		if(this.get('model.showFullName') !== true)
		{
			return "";
		}
		else
		{
			return "";
		}
	}),
	actions:
	{
		update: function()
		{
			var user = this.get('content');
			//console.log(this.get('session.isAuthenticated'));
			user.set('full_name', this.get('model.full_name'));
			user.set('display_name', this.get('model.display_name'));
			user.set('gender', this.get('model.gender'));
			user.set('email', this.get('model.email'));
			user.set('facebook_url', this.get('model.facebook_url'));
			user.set('twitter_url', this.get('model.twitter_url'));
			user.set('webpage_url', this.get('model.webpage_url'));
			user.set('show_full_name', this.get('model.show_full_name'));
			if(this.get('dateOfBirth') !== null && this.get('dateOfBirth') !== '')
			{
				user.set('date_of_birth', moment(this.get('dateOfBirth')).toDate());	
			}
			user.set('show_full_name', this.get('model.show_full_name'));
			//user.set('password', this.get('newPassword'));
			user.set('password', '12345678');
			var controller = this;
			user.save().then(function()
			{
				controller.transitionTo('user', user);
			}, function()
			{
				alert('failed to save user!');
			});
		}
	}
});
 