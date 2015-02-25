App.PostsRoute = Ember.Route.extend
  model: ->
    @get('posts').findAll('post')
