# for more details see: http://emberjs.com/guides/models/defining-models/
#Category solves the Ember.js warning since categorie for a model was causing problems...
App.Categorie = DS.Model.extend
App.Category = DS.Model.extend
  categoryName: DS.attr 'string'
