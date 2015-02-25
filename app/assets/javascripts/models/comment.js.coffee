# for more details see: http://emberjs.com/guides/models/defining-models/

App.Comment = DS.Model.extend
  softDelete: DS.attr 'boolean'
  softDeleteDate: DS.attr 'date'
  text: DS.attr 'string'
  hidden: DS.attr 'boolean'
  empathyLevel: DS.attr 'number'
