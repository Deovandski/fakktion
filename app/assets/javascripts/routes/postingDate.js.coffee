App.PostingDateRoute = Ember.Route.extend
  model: -> @store.find 'postingDate', params.id
