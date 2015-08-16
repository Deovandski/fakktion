import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	currentPassword: "",
	newPassword: "",
	newPasswordConfirmation: "",
	dateOfBirth: null,
	clientSideValidationComplete: false,
	showPassword: false,
	showExtra: false,
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
	verifyCurrentPassword: Ember.computed('currentPassword', function()
	{
		if(this.get('currentPassword').length < 8)
		{
			if(this.get('currentPassword').length === 0)
			{
				this.set("clientSideValidationComplete",true);
				return "";
			}
			else
			{
				this.set("clientSideValidationComplete",false);
				return "Too Short";
			}
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyNewPassword: Ember.computed('newPassword', 'currentPassword', function()
	{
		if(this.get('newPassword').length < 8)
		{
			if(this.get('newPassword').length === 0)
			{
				if(this.get('currentPassword').length !== 0)
				{
					this.set("clientSideValidationComplete",false);
					return "Cannot be left empty!";
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
				return "Too Short";
			}
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
		{
			this.set("clientSideValidationComplete",false);
			return "male/female/other";
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "";
		}
	}),
	verifyFacebookURL: Ember.computed('model.facebook_url', function()
	{
		if(this.get('model.facebook_url') !== '')
		{
			if(this.get('model.facebook_url').indexOf("facebook") !== -1)
			{
				this.set("clientSideValidationComplete", true);
				return "";
			}
			else
			{
				this.set("clientSideValidationComplete", false);
				return "Invalid Facebook URL";
			}
		}
		else
		{
			this.set("clientSideValidationComplete", true);
			return "https://www.facebook.com/example";
		}
	}),
	verifyTwitterURL: Ember.computed('model.twitter_url', function()
	{
		if(this.get('model.twitter_url') !== '')
		{
			if(this.get('model.twitter_url').indexOf("twitter") !== -1)
			{
				this.set("clientSideValidationComplete", true);
				return "";
			}
			else
			{
				this.set("clientSideValidationComplete", false);
				return "Invalid Twitter URL";
			}
		}
		else
		{
			this.set("clientSideValidationComplete", true);
			return "https://twitter.com/example";
		}
	}),
	verifyWebpageURL: Ember.computed('model.webpage_url', function()
	{
		
		if(this.get('model.webpage_url') !== '')
		{
			if(this.get('model.webpage_url').length < 10)
			{
				this.set("clientSideValidationComplete", false);
				return "Invalid URL";
			}
			else
			{
				this.set("clientSideValidationComplete", true);
				return "";
			}
		}
		else
		{
			this.set("clientSideValidationComplete",true);
			return "http://www.example.com https://www.example.com";
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
		setShowPassword: function(password)
		{
			this.set('showPassword', password);
		},
		setExtraPassword: function(extra)
		{
			this.set('showExtra', extra);
		},
		update: function()
		{
			if(this.get('clientSideValidationComplete'))
			{
				var user = this.get('content');
				if(this.get('dateOfBirth') !== null && this.get('dateOfBirth') !== '')
				{
					user.set('date_of_birth', moment(this.get('dateOfBirth')).toDate());	
				}
				if(this.get('newPassword') !== null && this.get('newPassword') !== '')
				{
					user.set('password', this.get('newPassword'));	
				}
				else
				{
					user.set('password', "");
				}
				if(this.get('currentPassword') !== null && this.get('currentPassword') !== '')
				{
					user.set('current_password', this.get('currentPassword'));
				}
				else
				{
					user.set('current_password', "");
				}
				var controller = this;
				user.save().then(function()
				{
					controller.transitionToRoute('user', user);	
				}, function()
				{
					alert('failed to save user!');
				});
			}
			else
			{
				alert("(Client 402) Failed to save user... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
			}
		}
	}
});
 