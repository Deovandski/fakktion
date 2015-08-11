import Ember from "ember";

export default Ember.Controller.extend
({
	needs: ['application'],
	title: "",
	text: "",
	factLink: "",
	fictionLink: "",
	genreID: Ember.computed('controllers.application.selectedGID', function()
	{
		return this.get('controllers.application.selectedGID');
	}),
	genreName: Ember.computed('controllers.application.selectedGN', function()
	{
		return this.get('controllers.application.selectedGN');
	}),
	factTypeID: Ember.computed('controllers.application.selectedFTID', function()
	{
		return this.get('controllers.application.selectedFTID');
	}),
	factTypeName: Ember.computed('controllers.application.selectedFTN', function()
	{
		return this.get('controllers.application.selectedFTN');
	}),
	categoryID: Ember.computed('controllers.application.selectedCID', function()
	{
		return this.get('controllers.application.selectedCID');
	}),
	categoryName: Ember.computed('controllers.application.selectedCN', function()
	{
		return this.get('controllers.application.selectedCN');
	}),
	verifyTitle: Ember.computed('title', function()
	{
		if(this.get('title').length < 10)
		{return "Too short";}
		else
		{return "MKay";}
	}),
	verifyText: Ember.computed('text', function()
	{
		if(this.get('text').length < 10)
		{return "Too short";}
		else
		{return "MKay";}
	}),
	verifyFactLink: Ember.computed('factLink', function()
	{
		if(this.get('factLink').length < 4)
		{return "Paste complete URL";}
		else
		{return "MKay";}
	}),
	verifyFictionLink: Ember.computed('fictionLink', function()
	{
		if(this.get('fictionLink').length < 4)
		{return "Paste complete URL";}
		else
		{return "MKay";}
	}),
	verifyGenre: Ember.computed('genreID', function()
	{
		if(this.get('genreID') === 0)
		{return "Please Select/Create Genre";}
		else
		{return "MKay";}
	}),
	verifyFactType: Ember.computed('factTypeID', function()
	{
		if(this.get('factTypeID') === 0)
		{return "Please Select/Create Fact Type";}
		else
		{return "MKay";}
	}),
	verifyCategory: Ember.computed('categoryID', function()
	{
		if(this.get('categoryID') === 0)
		{return "Please Select/Create Category";}
		else
		{return "MKay";}
	}),
	actions:
	{
		create: function()
		{
			var post = this.store.createRecord('post',
			{
				user_id: this.get('session.secure.userId'),
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
			post.save().then(function()
			{
				console.log('post created!');
				self.transitionTo('post', post);
				self.set('postName', '');
			}, function()
			{
				alert('failed to create post!');
			});
		}
	}
});
