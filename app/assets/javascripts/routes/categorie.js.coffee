App.CategorieRoute = Ember.Route.extend
  model: -> @store.find 'categorie', params.id
