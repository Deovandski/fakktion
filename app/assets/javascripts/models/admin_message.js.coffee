# for more details see: http://emberjs.com/guides/models/defining-models/

App.AdminMessage = DS.Model.extend
  title: DS.attr 'string'
  message: DS.attr 'string'
