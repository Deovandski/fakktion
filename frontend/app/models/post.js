import DS from "ember-data";

export default DS.Model.extend({
  user_id: DS.attr ('number'),
  genre_id: DS.attr ('number'),
  topic_id: DS.attr ('number'),
  categorie_id: DS.attr ('number'),
  fact_type_id: DS.attr ('number'),
  factLink: DS.attr ('string'),
  fictionLink: DS.attr ('string'),
  title: DS.attr ('string'),
  importance: DS.attr ('number'),
  softDelete: DS.attr ('boolean'),
  softDeleteDate: DS.attr ('date'),
  hidden: DS.attr ('boolean')
});
