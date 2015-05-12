// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
App.IndexController = Ember.ObjectController.extend({
  needs: ['application'],
  genreSelected: 0,
    
  //For Future Use when SearchByTopic is implemented// daFilter: 'blue',
  //  filtered: function(){
  //  return this.get('model').filterBy('color', this.get('daFilter'));
  //}.property('model.@each.color', 'daFilter')
  filteredPosts: function(){
    //this.get('controllers.ApplicationController.genreSelected')
    console.log('Filter called');
    console.log('SelectedGenre DEBUG: ' + this.get('genreSelected'));
      if(this.get('genreSelected') != 0)
      {
        return this.get('posts').filterBy('genre_id', this.get('genreSelected'));      
        console.log('Filter called. Result: Return all Posts with genre_id of' + this.get('genreSelected'));
      }
      else
      {
        return this.get('posts');
        console.log('Filter called. Result: Return all Posts');
      }
  }.observes('controllers.ApplicationController.genreSelected').property()
  //.property('model.@each.color', 'daFilter')
});
