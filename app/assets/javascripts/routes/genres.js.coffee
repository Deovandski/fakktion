App.GenresRoute = Ember.Route.extend
  model: -> @store.find 'genre'
