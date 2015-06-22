// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

App.IndexController = Ember.Controller.extend({
	needs: ['application'],
	genreSelected: 0,
	factTypeSelected: 0,
	categorieSelected: 0,
	postingDateSelected: 0,
	//For Future Use when SearchByTopic is implemented// daFilter: 'blue',
	//filtered: function(){
	//return this.get('model').filterBy('color', this.get('daFilter'));
	//}.property('model.@each.color', 'daFilter')
	filteredPosts: Ember.computed('controllers.application.genreSelected', 'controllers.application.factTypeSelected', 'controllers.application.categorieSelected', function(){
		//controllers DEBUG console.log(this.get('controllers'));
		//Get variables from ApplicationController
		this.set('genreSelected', this.get('controllers.application.genreSelected'));
		this.set('factTypeSelected', this.get('controllers.application.factTypeSelected'));
		this.set('categorieSelected', this.get('controllers.application.categorieSelected'));
		//console.log('Variables Debug: ');
		//console.log('SelectedGenre DEBUG: ' + this.get('genreSelected'));
		//console.log('factTypeSelected DEBUG: ' + this.get('factTypeSelected'));
		//console.log('categorieSelected DEBUG: ' + this.get('categorieSelected'));
		console.log('Filter called');   
		//// MAIN FILTER
		// ALL NOT SELECTED
		if(this.get('genreSelected') == 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') == 0)
		{
	      console.log('Result: Return all Posts');
	      return this.get('posts');
		}  
     	// INDIVIDUAL SELECTION
		else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') == 0)
      {
			console.log('Result: Return all Posts by filtering Genre');
         return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected')));
     	}
  		else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') == 0)
	  	{
   	   console.log('Result: Return all Posts by filtering FactType');
         return this.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeSelected')));
	  	}
     	else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') != 0)
     	{
         console.log('Result: Return all Posts by filtering Categorie');
         return this.get('posts').filterBy('categorie_id', parseInt(this.get('categorieSelected')));
     	}
     	// TWO AT A TIME SELECTION
     	else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') == 0)
     	{
			console.log('Result: Return all Posts by filtering Genre and FactType');
         return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected'))).filterBy('fact_type_id', parseInt(this.get('factTypeSelected')));
     	}
     	else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') != 0)
     	{
      	console.log('Result: Return all Posts by filtering FactType and Categorie');
      	return this.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeSelected'))).filterBy('categorie_id', parseInt(this.get('categorieSelected')));
     	}
     	else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') != 0)
     	{
      	console.log('Result: Return all Posts by filtering Genre and Categorie');
         return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected'))).filterBy('categorie_id', parseInt(this.get('categorieSelected')));
     	}
     	// THREE AT A TIME SELECTION
     	// TODO when postingDate is refactored.
      else
      {
      	console.log('Result: Return all Posts by filtering Genre, FactType and Categorie');
         return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected'))).filterBy('fact_type_id', parseInt(this.get('factTypeSelected'))).filterBy('categorie_id', parseInt(this.get('categorieSelected')));
      }
	})
})
