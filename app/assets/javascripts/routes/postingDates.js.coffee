App.PostingDatesRoute = Ember.Route.extend
  model: -> @store.find 'postingDate'
