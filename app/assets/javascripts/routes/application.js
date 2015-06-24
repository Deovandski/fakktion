App.ApplicationRoute = Ember.Route.extend({
  model: function() {
      return Ember.Object.create({
         genres: this.store.findAll('genre'),
         factTypes: this.store.findAll('factType'),
         categories: this.store.findAll('category')
      })
  }
});
