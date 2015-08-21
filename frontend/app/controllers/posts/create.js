import Ember from "ember";

export default Ember.Controller.extend
({
	application: Ember.inject.controller('application'),
	title: "",
	text: "",
	factLink: "",
	fictionLink: "",
	clientSideValidationComplete: false,
	genreID: Ember.computed('application.selectedGID', function()
	{
		return this.get('application.selectedGID');
	}),
	factTypeID: Ember.computed('application.selectedFTID', function()
	{
		return this.get('application.selectedFTID');
	}),
	categoryID: Ember.computed('application.selectedCID', function()
	{
		return this.get('application.selectedCID');
	}),
	topicID: Ember.computed('application.selectedTID', function()
	{
		return this.get('application.selectedTID');
	}),
	genreName: Ember.computed('application.selectedGN', function()
	{
		return this.get('application.selectedGN');
	}),
	factTypeName: Ember.computed('application.selectedFTN', function()
	{
		return this.get('application.selectedFTN');
	}),
	categoryName: Ember.computed('application.selectedCN', function()
	{
		return this.get('application.selectedCN');
	}),
	topicName: Ember.computed('application.selectedTN', function()
	{
		return this.get('application.selectedTN');
	}),
	verifyTitle: Ember.computed('title', function()
	{
		if(this.get('title').length < 10)
		{
			this.set('clientSideValidationComplete',false);
			return "Too short";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyText: Ember.computed('text', function()
	{
		if(this.get('text').length < 10)
		{
			this.set('clientSideValidationComplete',false);
			return "Too short";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyFactLink: Ember.computed('factLink', function()
	{
		if(this.get('factLink').length < 4)
		{
			this.set('clientSideValidationComplete',false);
			return "Past Complete URL";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyFictionLink: Ember.computed('fictionLink', function()
	{
		if(this.get('fictionLink').length < 4)
		{
			this.set('clientSideValidationComplete',false);
			return "Past Complete URL";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyGenre: Ember.computed('genreID', function()
	{
		if(this.get('genreID') === 0)
		{
			this.set('clientSideValidationComplete',false);
			return "Missing Genre";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyFactType: Ember.computed('factTypeID', function()
	{
		if(this.get('factTypeID') === 0)
		{
			this.set('clientSideValidationComplete',false);
			return "Missing Fact Type";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyCategory: Ember.computed('categoryID', function()
	{
		if(this.get('categoryID') === 0)
		{
			this.set('clientSideValidationComplete',false);
			return "Missing Category";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	verifyTopic: Ember.computed('topicID', function()
	{
		if(this.get('topicID') === 0)
		{
			this.set('clientSideValidationComplete',false);
			return "Missing Topic";
		}
		else
		{
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	actions:
	{
		create: function()
		{
			if(this.get('clientSideValidationComplete') === true)
			{
				var self = this;
				var store = this.store;
				var post = store.createRecord('post',
				{
					user_id: this.get('session.secure.userId'),
					title: this.get('title'),
					text: this.get('text'),
					fact_link: this.get('factLink'),
					fiction_link: this.get('fictionLink'),
					hidden: false,
					softDelete: false,
					genre: store.find('genre', parseInt(this.get('genreID')))
				}); //FIX
				console.log(post.genre); //>> Computed Property
				console.log(post.genre.genre_id); //>> Undefined
				console.log(post.genre.id); //>> Undefined
				post.set('genre_id', this.get('genreID')); 
				console.log(post.genre_id); //>> 1
				post.save().then(function()
				{
					self.transitionToRoute('post', post);
				}, function()
				{
					alert('(Server 402) failed to create Post... Check your input and try again!');
				});
			}
			else
			{
				alert("(Client 402) Failed to create Post... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
			}
		}
	}
});
