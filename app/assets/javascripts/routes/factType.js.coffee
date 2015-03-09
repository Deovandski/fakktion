App.FactTypeRoute = Ember.Route.extend
  model: -> @store.find 'factType', params.id
