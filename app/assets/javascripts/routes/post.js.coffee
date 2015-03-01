App.PostRoute = Ember.Route.extend
  model: -> @store.find 'post', params.id
