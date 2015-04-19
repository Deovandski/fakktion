App.FactPostDatesRoute = Ember.Route.extend
  model: -> @store.find 'factPostDates'
