# for more details see: http://emberjs.com/guides/models/defining-models/

App.Post = DS.Model.extend
  factLink: DS.attr 'string'
  fictionLink: DS.attr 'string'
  postName: DS.attr 'string'
  importance: DS.attr 'number'
  softDelete: DS.attr 'boolean'
  softDeleteDate: DS.attr 'date'
  hidden: DS.attr 'boolean'
