import Ember from "ember";

export default Ember.Controller.extend
({
	needs: ['application'],
	title: "",
	text: "",
	fact_link: "",
	fictionLink: "",
	clientSideValidationComplete: false,
	changeTags: false,
	nextGenreID: Ember.computed('controllers.application.selectedGID', function()
	{
		return this.get('controllers.application.selectedGID');
	}),
	nextGenreName: Ember.computed('controllers.application.selectedGN', function()
	{
		return this.get('controllers.application.selectedGN');
	}),
	nextFactTypeID: Ember.computed('controllers.application.selectedFTID', function()
	{
		return this.get('controllers.application.selectedFTID');
	}),
	nextFactTypeName: Ember.computed('controllers.application.selectedFTN', function()
	{
		return this.get('controllers.application.selectedFTN');
	}),
	nextCategoryID: Ember.computed('controllers.application.selectedCID', function()
	{
		return this.get('controllers.application.selectedCID');
	}),
	nextCategoryName: Ember.computed('controllers.application.selectedCN', function()
	{
		return this.get('controllers.application.selectedCN');
	}),
	nextTopicID: Ember.computed('controllers.application.selectedTID', function()
	{
		return this.get('controllers.application.selectedTID');
	}),
	nextTopicName: Ember.computed('controllers.application.selectedTN', function()
	{
		return this.get('controllers.application.selectedTN');
	}),
	verifyTitle: Ember.computed('model.title', function()
	{
		if(this.get('model.title').length < 10)
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
	verifyText: Ember.computed('model.text', function()
	{
		if(this.get('model.text').length < 10)
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
	verifyfactLink: Ember.computed('model.fact_link', function()
	{
		if(this.get('model.fact_link').length < 4)
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
	verifyFictionLink: Ember.computed('model.fiction_link', function()
	{
		if(this.get('model.fiction_link').length < 4)
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
	verifyGenre: Ember.computed('model.genreID', function()
	{
		if(this.get('model.genreID') === 0)
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
	verifyFactType: Ember.computed('model.factTypeID', function()
	{
		if(this.get('model.factTypeID') === 0)
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
	verifyCategory: Ember.computed('model.categoryID', function()
	{
		if(this.get('model.categoryID') === 0)
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
	verifyTopic: Ember.computed('model.topicID', function()
	{
		if(this.get('model.topicID') === 0)
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
		setChangeTags: function(varBoolean)
		{
			this.set('changeTags', varBoolean);
		},
		update: function()
		{
			if(this.get('clientSideValidationComplete'))
			{
				var post = this.get('content');
				if(this.get('changeTags') === true)
				{
					post.set('categorie_id', this.get('nextCategoryID'));	
					post.set('topic_id', this.get('nextTopicID'));	
					post.set('genre_id', this.get('nextGenreID'));	
					post.set('fact_type_id', this.get('nextFactTypeID'));	
				}
				var controller = this;
				post.save().then(function()
				{
					controller.transitionToRoute('post', post);	
				}, function()
				{
					alert('failed to save post!');
				});
			}
			else
			{
				alert("(Client 402) Failed to save post... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
			}
		}
	}
});
