App.IndexRoute = Ember.Route.extend({
  model: function() {
      return Ember.RSVP.hash({
         posts: this.store.find('post')
      })
  },
  modelG: function() {
    return Ember.RSVP.hash({
       posts: this.store.find('post', {genre_id: this.get('genreSelected')})
      })
  }
});
