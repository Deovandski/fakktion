import Ember from "ember";
/* Abbreviations:
GID: Genre_id
CID: category_id
TID: topic_id
FTID: fact_type_id
------------------
GN: GenreName
CN: CategoryName
TN: Topicname
FTN: FactTypeName
------------------
GP: GenrePartial
CP: CategoryPartial
FTP: FactTypePartial
PDP: PostingDatePartial
------------------
GPV: Genres Partial Visibility
CPV: Category Partial Visibility
FTPV: FactType Partial Visibility
PDPV: PostingDate Partial Visibility
*/
export default Ember.Controller.extend
({
	// Variables Section
	selectedGID: 0,
	selectedCID: 0,
	selectedTID: 0,
	selectedFTID: 0,
	selectedGN: 'nil',
	selectedCN: 'nil',
	selectedTN: 'nil',
	selectedFTN: 'nil',
	searchTopicByName: 'nil',
	showGP: true,
	showCP: true,
	showFTP: true,
	showPDP: true,

	
	// Central Panel and Sidebars Visibility Boolean Check
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
	displaySideBars: Ember.computed('currentPath', function()
	{
		if(this.get('currentPath') === 'index' || 'posts.create')
			{return true;}
		else
			{return false;}
	}),
	// Tags Selected Boolean check.
	isGenreSelected: Ember.computed('selectedGID', function()
	{
		if(this.get('selectedGID') !== 0)
			{return true;}
		else
			{return false;}
	}),
	isFactTypeSelected: Ember.computed('selectedFTID', function()
	{
		if(this.get('selectedFTID') !== 0)
			{return true;}
		else
			{return false;}
	}),
	isCategorySelected: Ember.computed('selectedCID', function()
	{
		if(this.get('selectedCID') !== 0)
			{return true;}
		else
			{return false;}
	}),
	isTopicSelected: Ember.computed('selectedCID', function()
	{
		if(this.get('selectedTID') !== 0)
			{return true;}
		else
			{return false;}
	}),
	isPostDateSelected: function()
	{
		return false; //TODO
	},
	// Partials Visibility Boolean Check
	displayGP: Ember.computed('showGP', function()
	{
		if(this.get('showGP') === true)
			{return true;}
		else
			{return false;}
	}),
	displayCP: Ember.computed('showCP', function()
	{
		if(this.get('showCP') === true)
			{return true;}
		else
			{return false;}
	}),
	displayFTP: Ember.computed('showFTP', function()
	{
		if(this.get('showFTP') === true)
			{return true;}
		else
			{return false;}
	}),
	displayPDP: Ember.computed('showPDP', function()
	{
		if(this.get('showPDP') === true)
			{return true;}
		else
			{return false;}
	}),
	actions: 
	{
		//Set ID Tag Methods
		setGID: function(genre) 
		{ 
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
		//Set Partial Visibility Methods
		setGPV: function(varBoolean)
		{ 
			this.set('showGP', varBoolean);
		},
		setCPV: function(varBoolean) 
		{ 
			this.set('showCP', varBoolean);
		},
		setFTPV: function(varBoolean)
		{ 
			this.set('showFTP', varBoolean);
		},
		setPDPV: function(varBoolean)
		{ 
			this.set('showPDP', varBoolean);
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
