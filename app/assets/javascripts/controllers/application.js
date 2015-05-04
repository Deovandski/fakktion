// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

App.ApplicationController = Ember.ObjectController.extend({
  genreSelected: 0,
  categorieSelected: 0,
  factTypeSelected: 0,
  //needs: ['genre','genres', 'factType', 'factTypes','postingDate'
  //,'postingDates','categorie','categories','post','posts'],
  filterPostsMessageSender: function() 
  {    
    //console.log('filterPosts function hit');
    //console.log('filterPosts.GenreSelected: ' + this.get('genreSelected'));
    if (this.get('genreSelected') != 0)
    {
      if(this.get('factTypeSelected') != 0)
      {
        
      }
      else
      {
       // Genre Only
       //this.transitionToRoute('postsG');
      }
    }
    else
    {
      console.log('Genre = 0');
    }

  },
  actions: 
  {
    selectGenre: function(genre) 
    { 
       this.set('genreSelected', genre.id);
       this.filterPostsMessageSender();
       //console.log('selectGenre.Genre.id: ' + genre.id);
       //console.log('selectGenre.genreSelected: ' + this.get('genreSelected'));
    },
    selectCategorie: function(categorie) 
    { 
      this.set('categorieSelected', categorie.id);
      this.filterPostsMessageSender();
    },
    selectFactType: function(factType) 
    { 
      this.set('factTypeSelected', factType.id);
      this.filterPostsMessageSender();
    }
  }
})
