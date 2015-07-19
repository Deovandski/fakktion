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
		if(this.get('fullName').length < 10)
			{return "Write your name";}
		else
			{return "MKay";}
	}),
	verifyDisplayName: Ember.computed('displayName', function()
	{
		if(this.get('displayName').length < 10)
			{return "Too short";}
		else
			{return "MKay";} // TEST AGAINST OTHER USERNAMES
	}),
	verifyEmail: Ember.computed('email', function()
	{
		if(this.get('email').length < 4)
			{return "Paste complete URL";}
		else
			{return "MKay";} // TEST AGAINST OTHER EMAILS
	}),
	verifyPassword: Ember.computed('password', function()
	{
		if(this.get('password').length < 4)
			{return "Paste complete URL";}
		else
			{return "MKay";}
	}),
	verifyPasswordConfirmation: Ember.computed('passwordConfirmation', function()
	{
		if(this.get('passwordConfirmation').length < 4)
			{return "8+";}
		else
			{return "MKay";}
	}),
	verifyGender: Ember.computed('gender', function()
	{
		console.log(this.get('gender').toLowerCase()) // NOT WORKING
		if(this.get('gender').toLowerCase() != "male" || "female" || "other" )
			{return "male/female/other";}
		else
			{return "MKay";}
	}),
	verifyFacebookURL: Ember.computed('facebookURL', function()
	{
		if(this.get('facebookURL').length < 4)
			{return "Paste complete URL";}
		else
			{return "MKay";}
	}),
	verifyTwitterURL: Ember.computed('twitterURL', function()
	{
		if(this.get('twitterURL').length < 4)
			{return "Paste complete URL";}
		else
			{return "MKay";}
	}),
	verifyWebpageURL: Ember.computed('webpageURL', function()
	{
		if(this.get('webpageURL').length < 4)
			{return "Paste complete URL";}
		else
			{return "MKay";}
	}),
	verifyLegalTermsRead: Ember.computed('legalTermsRead', function()
	{
		if(this.get('legalTermsRead') != true)
			{return "Must accept!";}
		else
			{return "MKay";}
	}),
	verifyPrivacyTermsRead: Ember.computed('privacyTermsRead', function()
	{
		if(this.get('privacyTermsRead') != true)
			{return "Must accept!";}
		else
			{return "MKay";}
	}),
  actions: {
    create: function() {
      var post = this.store.createRecord('post', {
        user_id: this.get('session.currentUser.id'),
        title: this.get('title'),
        text: this.get('text'),
        fact_link: this.get('factLink'),
        fiction_link: this.get('fictionLink'),
        genre_id: this.get('genreID'),
        topic_id: 1,
        fact_type_id: this.get('factTypeID'),
        categorie_id: this.get('categoryID'),
        hidden: false,
        softDelete: false,
      });
      var self = this;
      post.save().then(function() {
        console.log('post created!');
        self.transitionTo('post', post);
        self.set('postName', '');
      }, function() {
        alert('failed to create post!');
      });
    }
  }
});
