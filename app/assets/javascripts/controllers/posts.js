// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
App.PostsController = Ember.ObjectController.extend({
  model: function() {
      return Ember.RSVP.hash({
         posts: this.store.find('post')
      });
  },
  modelG: function() {
    return Ember.RSVP.hash({
       posts: this.store.find('post', {genre_id: this.get('genreSelected')})
      });
  }
})
