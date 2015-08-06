import Ember from "ember";

export default Ember.Controller.extend
({
	fullName: "",
	displayName: "",
	email: "",
	password: "",
	passwordConfirmation: "",
	gender: "",
	facebookURL: "",
	twitterURL: "",
	webpageURL: "",
	legalTermsRead: false,
	PrivacyTermsRead: false,
	verifyFullName: Ember.computed('fullName', function()
	{
		if(this.get('fullName').length < 1)
			{return "Cannot be empty";}
		else
			{return "";}
	}),
	verifyDisplayName: Ember.computed('displayName', function()
	{
		if(this.get('displayName').length < 5)
			{return "Too short";}
		else
			{
				if(this.model.get('users').isAny('display_name', this.get('displayName')))
					{return "This Display Name is already in use...";}
				else
					{return "";}
			}
	}),
	verifyEmail: Ember.computed('email', function()
	{
		if(this.get('email').length < 4)
			{return "Too short";}
		else
			{
				if(this.model.get('users').isAny('email', this.get('email')))
					{return "This Email is already in use...";}
				else
					{return "";}
			}
	}),
	verifyPassword: Ember.computed('password', function()
	{
		if(this.get('password').length < 4)
			{return "Too short...";}
		else
			{return "";}
	}),
	verifyPasswordConfirmation: Ember.computed('passwordConfirmation', function()
	{
		if(this.get('passwordConfirmation') !== this.get('password'))
			{return "Does not match!";}
		else
			{return "";}
	}),
	verifyGender: Ember.computed('gender', function()
	{
		//console.log(this.get('gender').toLowerCase());
		if(this.get('gender').toLowerCase() !== "male" && this.get('gender').toLowerCase() !== "female" && this.get('gender').toLowerCase() !== "other")
			{return "male/female/other";}
		else
			{return "";}
	}),
	verifyFacebookURL: Ember.computed('facebookURL', function()
	{
		if(this.get('facebookURL').length < 4)
			{return "Paste complete URL";}
		else
			{return "";}
	}),
	verifyTwitterURL: Ember.computed('twitterURL', function()
	{
		if(this.get('twitterURL').length < 4)
			{return "Paste complete URL";}
		else
			{return "";}
	}),
	verifyWebpageURL: Ember.computed('webpageURL', function()
	{
		if(this.get('webpageURL').length < 4)
			{return "Paste complete URL";}
		else
			{return "";}
	}),
	verifyLegalTermsRead: Ember.computed('legalTermsRead', function()
	{
		if(this.get('legalTermsRead') !== true)
			{return "Must accept!";}
		else
			{return "";}
	}),
	verifyPrivacyTermsRead: Ember.computed('privacyTermsRead', function()
	{
		if(this.get('privacyTermsRead') !== true)
			{return "Must accept!";}
		else
			{return "";}
	}),

  actions: {
//:date_of_birth, :personal_message, :is_banned_date
//:number_of_posts, :number_of_comments
//:is_admin, :is_super_user, :sign_in_count, :password, :number_of_comments
//:number_of_posts, :last_sign_in_at, :reset_password_sent_at, :reset_password_token
// TODO BIRTHDAY
//{{moment-format date}}
//{{moment-to-now date}}
    create: function() {
      var user = this.store.createRecord('user', {
			full_name: this.get('fullName'),
			display_name: this.get('displayName'),
			gender: this.get('gender'),
			email: this.get('email'),
			password: this.get('password'),
			facebook_url: this.get('facebookURL'),
			twitter_url: this.get('twitterURL'),
			webpage_url: this.get('webpageURL'),
			legal_terms_read: this.get('legalTermsRead'),
			privacy_terms_read: this.get('PrivacyTermsRead'),
			is_banned: false,
			is_admin: false,
			is_super_user: false
      });
      var self = this;
      user.save().then(function() {
        console.log('user created!');
        self.transitionTo('user', user);
        //self.set('postName', '');
      }, function() {
        alert('(402) failed to create User... Check your input and try again!');
      });
    }
  }
});
