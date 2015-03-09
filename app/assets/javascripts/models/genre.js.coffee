# for more details see: http://emberjs.com/guides/models/defining-models/

App.Genre = DS.Model.extend
  posts: DS.hasMany('post')
  genreName: DS.attr('string')
