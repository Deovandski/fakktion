App.ApplicationRoute = Ember.Route.extend({
  model: function() {
      return Ember.RSVP.hash({
         genres: this.store.findAll('genre'),
         factTypes: this.store.findAll('factType'),
         categories: this.store.findAll('category')
      })
  }
});
