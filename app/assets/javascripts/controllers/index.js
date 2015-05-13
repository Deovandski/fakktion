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
    //controllers DEBUG console.log(this.get('controllers'));
    //Get variables from ApplicationController
    this.set('genreSelected', this.get('controllers.application.genreSelected'));
    console.log('Filter called');
    console.log('SelectedGenre DEBUG: ' + this.get('genreSelected'));
      if(this.get('genreSelected') != 0)
      {
        console.log('Result: Return all Posts with genre_id of ' + this.get('genreSelected'));
        return this.get('posts').filterBy('genre_id', parseInt(this.get('genreSelected')));      
      }
      else
      {
        console.log('Result: Return all Posts');
        return this.get('posts');
      }
  }.property('controllers.application.genreSelected')
  //.property('model.@each.color', 'daFilter')
});
