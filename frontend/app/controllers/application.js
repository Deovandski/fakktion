import Ember from "ember";

export default Ember.Controller.extend({

	// Tag ID Variables
	selectedGID: 0,
	selectedCID: 0,
	selectedFTID: 0,
	// Tag Name Variables
	selectedGN: 'nil',
	selectedCN: 'nil',
	selectedFTN: 'nil',

	// Methods for Tags Boolean check.
	isGenreSelected: Ember.computed('selectedGID', function()
	{
		if(this.get('selectedGID') !== 0)
		{
			console.log('isGenreSelected method fired TRUE');
			return true;
		}
		else
		{
			console.log('isGenreSelected method fired FALSE');
			return false;
		}
	}),
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
		//Clear Tag Methods
		clearGenre: function() 
		{ 
			this.set('selectedGID', 0);
			this.set('selectedGN', 'nil');
		},
		//Logout method
		invalidateSession: function()
		{
			this.get('session').invalidate();
		}
	}
});
