App.CategoriesRoute = Ember.Route.extend
  model: -> @store.find 'categorie'
