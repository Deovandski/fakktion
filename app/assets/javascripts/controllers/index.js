// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
App.IndexController = Ember.ObjectController.extend({
  needs: ['application'],
  genreSelected: 0,
  factTypeSelected: 0,
  categorieSelected: 0,
  postingDateSelected: 0,
  //For Future Use when SearchByTopic is implemented// daFilter: 'blue',
  //  filtered: function(){
  //  return this.get('model').filterBy('color', this.get('daFilter'));
  //}.property('model.@each.color', 'daFilter')
  filteredPosts: function(){
    //controllers DEBUG console.log(this.get('controllers'));
    //Get variables from ApplicationController
    this.set('genreSelected', this.get('controllers.application.genreSelected'));
    this.set('factTypeSelected', this.get('controllers.application.factTypeSelected'));
    this.set('categorieSelected', this.get('controllers.application.categorieSelected'));
    this.set('postingDateSelected', this.get('controllers.application.postingDateSelected'));
    console.log('Variables Debug: ');
    console.log('SelectedGenre DEBUG: ' + this.get('genreSelected'));
    console.log('factTypeSelected DEBUG: ' + this.get('factTypeSelected'));
    console.log('categorieSelected DEBUG: ' + this.get('categorieSelected'));
    console.log('SelectedGenre DEBUG: ' + this.get('postingDateSelected'));
    console.log('Filter called');
    
         // MAIN FILTER
         // ALL NOT SELECTED
        if(this.get('genreSelected') == 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts');
            return this.get('posts');
        }
        
        // INDIVIDUAL SELECTION
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering Genre');
            return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected')));
        }
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering FactType');
            return this.get('posts').filterBy('fact_type_id', parseInt(this.get('factTypeSelected')));
        }
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering Categorie');
            return this.get('posts').filterBy('categorie_id', parseInt(this.get('categorieSelected')));
        }
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering PostingDate');
            return this.get('posts').filterBy('posting_date_id', parseInt(this.get('postingDateSelected')));
        }
        
        // TWO AT A TIME SELECTION
        
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering Genre and FactType');
            filter1 = this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected')));
            console.log(filter1.filterBy('fact_type_id', parseInt(this.get('factTypeSelected'))));
            return filter1.filterBy('fact_type_id', parseInt(this.get('factTypeSelected')));
            
        }
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering FactType and Categorie');
            
        }
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering Categorie and PostingDate');
            
        }
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering Genre and Categorie');
            
        }
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering Genre and PostingDate');
            
        }
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering FactType and PostingDate');
            
        }
        
        // THREE AT A TIME SELECTION
        else if(this.get('genreSelected') == 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering FactType,Categorie and PostingDate');
            
        }
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') == 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering Genre,Categorie and PostingDate');
            
        }
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') == 0 && this.get('postingDateSelected') != 0)
        {
            console.log('Result: Return all Posts by filtering Genre, FactType and PostingDate');
            
        }
        else if(this.get('genreSelected') != 0 && this.get('factTypeSelected') != 0 && this.get('categorieSelected') != 0 && this.get('postingDateSelected') == 0)
        {
            console.log('Result: Return all Posts by filtering Genre, FactType and PostingDate');
            
        }
        
      else
      {
          // Return with all filters...
            return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected')));
      }
  }.property('controllers.application.genreSelected','controllers.application.factTypeSelected')
  //.property('model.@each.color', 'daFilter')
});
