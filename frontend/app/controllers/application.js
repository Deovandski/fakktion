import Ember from "ember";

export default Ember.Controller.extend({

	// Tag ID Variables
	selectedGID: 0,
	selectedCID: 0,
	selectedTID: 0,
	selectedFTID: 0,
	// Tag Name Variables
	selectedGN: 'nil',
	selectedCN: 'nil',
	selectedTN: 'nil',
	selectedFTN: 'nil',
	searchTopicByName: 'nil',
	// Display Central Panel on specified pages
	displayCentralPanel: Ember.computed('currentPath', function()
	{
		if(this.get('currentPath') === 'index' || 'posts' || 'posts.create')
		{
			//console.log('Display Central Panel');
			//console.log(this.get('currentPath'));
			return true;
		}
		else
		{
			return false;
		}
	}),
	// Display Central Panel on only forum Related pages.
	displaySideBars: Ember.computed('currentPath', function()
	{
		if(this.get('currentPath') === 'index' || 'posts.create')
		{
			return true;
		}
		else
		{
			return false;
		}
	}),
	// Methods for Tags Boolean check.
	isGenreSelected: Ember.computed('selectedGID', function()
	{
		if(this.get('selectedGID') !== 0)
		{
			//console.log('isGenreSelected method fired TRUE');
			return true;
		}
		else
		{
			//console.log('isGenreSelected method fired FALSE');
			return false;
		}
	}),
	isFactTypeSelected: Ember.computed('selectedFTID', function()
	{
		if(this.get('selectedFTID') !== 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}),
	isCategorySelected: Ember.computed('selectedCID', function()
	{
		if(this.get('selectedCID') !== 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}),
	isTopicSelected: Ember.computed('selectedCID', function()
	{
		if(this.get('selectedTID') !== 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}),
	// TODO: REFACTOR CODE
	isPostDateSelected: function()
	{
		return false;
	},
	actions: 
	{
		//Set Tag Methods
		setGID: function(genre) 
		{ 
			//DEBUG ONLY
			//console.log('genre.id: ' + genre.id);
			this.set('selectedGID', genre.id);
			console.log('Application.selectedGID: ' + this.get('selectedGID'));
			//console.log('selectGenre.name: ' + genre.get('name'));
			this.set('selectedGN', genre.get('name'));
			//console.log('Application.selectedGN: ' + this.get('selectedGN'));
		},
		setCID: function(category) 
		{ 
			this.set('selectedCID', category.id);
			this.set('selectedCN', category.get('name'));
		},
		setFTID: function(factType) 
		{ 
			this.set('selectedFTID', factType.id);
			this.set('selectedFTN', factType.get('name'));
		},
		setTID: function() 
		{ 
			//TODO
		},
		//Clear Tag Methods
		clearGenre: function() 
		{ 
			this.set('selectedGID', 0);
			this.set('selectedGN', 'nil');
		},
		clearFactType: function() 
		{ 
			this.set('selectedFTID', 0);
			this.set('selectedFTN', 'nil');
		},
		clearCategory: function() 
		{ 
			this.set('selectedCID', 0);
			this.set('selectedCN', 'nil');
		},
		clearTopic: function() 
		{ 
			//TODO
		},
		clearPostDate: function() 
		{ 
			//TODO
		},
		//Logout method
		invalidateSession: function()
		{
			this.get('session').invalidate();
		}
	}
});
