import Ember from "ember";

export default Ember.Controller.extend
({
	needs: ['application'],
	title: "",
	text: "",
	factLink: "",
	fictionLink: "",
	clientSideValidationComplete: false,
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
	topicID: Ember.computed('controllers.application.selectedTID', function()
	{
		return this.get('controllers.application.selectedTID');
	}),
	topicName: Ember.computed('controllers.application.selectedTN', function()
	{
		return this.get('controllers.application.selectedTN');
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
				var post = this.store.createRecord('post',
				{
					user_id: this.get('session.secure.userId'),
					title: this.get('title'),
					text: this.get('text'),
					fact_link: this.get('factLink'),
					fiction_link: this.get('fictionLink'),
					genre_id: this.get('genreID'),
					topic_id: this.get('topicID'),
					fact_type_id: this.get('factTypeID'),
					categorie_id: this.get('categoryID'),
					hidden: false,
					softDelete: false,
				});
				var self = this;
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
