import Ember from "ember";

export default Ember.Controller.extend({
	needs: ['application'],
	genreID: 0,
	factTypeID: 0,
	categoryID: 0, 
	//For Future Use when SearchByTopic is implemented// daFilter: 'blue',
	//filtered: function(){
	//return this.model.get('posts').FilterBy('color', this.get('daFilter'));
	//}.property('model.@each.color', 'daFilter')
	filteredPosts: Ember.computed('controllers.application.selectedGID', 'controllers.application.selectedCID', 'controllers.application.selectedFTID', function(){
		//controllers DEBUG console.log(this.get('controllers'));
		//Get variables from ApplicationController
		this.set('genreID', this.get('controllers.application.selectedGID'));
		this.set('categoryID', this.get('controllers.application.selectedCID'));
		this.set('factTypeID', this.get('controllers.application.selectedFTID'));
		/*
		console.log('Variables Debug: ');
		console.log('genreID DEBUG: ' + this.get('genreID'));
		console.log('factTypeID DEBUG: ' + this.get('factTypeID'));
		console.log('categoryID DEBUG: ' + this.get('categoryID'));
		console.log('Filter called');
		*/
		//// MAIN FILTER
		// ALL NOT SELECTED
		if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0)
		{
	      console.log('Result: Return all Posts');
	      return this.model.get('posts');
		}  
     	// INDIVIDUAL SELECTION
		else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') === 0)
      {
			console.log('Result: Return all Posts by filtering Genre');
         return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID')));
     	}
  		else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0)
	  	{
   	   console.log('Result: Return all Posts by filtering FactType');
         return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID')));
	  	}
     	else if(this.get('genreID') === 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0)
     	{
         console.log('Result: Return all Posts by filtering Categorie');
         return this.model.get('posts').filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
     	// TWO AT A TIME SELECTION
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') !== 0 && this.get('categoryID') === 0)
     	{
			console.log('Result: Return all Posts by filtering Genre and FactType');
         return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID')));
     	}
     	else if(this.get('genreID') === 0 && this.get('factTypeID') !== 0 && this.get('categoryID') !== 0)
     	{
      	console.log('Result: Return all Posts by filtering FactType and Categorie');
      	return this.model.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
     	else if(this.get('genreID') !== 0 && this.get('factTypeID') === 0 && this.get('categoryID') !== 0)
     	{
      	console.log('Result: Return all Posts by filtering Genre and Categorie');
         return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
     	}
     	// THREE AT A TIME SELECTION
     	// TODO when postingDate is refactored.
      else
      {
      	console.log('Result: Return all Posts by filtering Genre, FactType and Categorie');
         return this.model.get('posts').filterBy('genre_id', parseInt(this.get('genreID'))).filterBy('fact_type_id', parseInt(this.get('factTypeID'))).filterBy('categorie_id', parseInt(this.get('categoryID')));
      }
	})
});
