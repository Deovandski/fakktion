App.GenreRoute = Ember.Route.extend
  model: -> @store.find 'genre'
