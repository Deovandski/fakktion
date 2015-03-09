App.FactTypesRoute = Ember.Route.extend
  model: -> @store.find 'factType'
