import DS from "ember-data";

export default DS.Model.extend({
  soft_delete: DS.attr ('boolean'),
  soft_delete_date: DS.attr ('date'),
  text: DS.attr ('string'),
  hidden: DS.attr ('boolean'),
  empathy_level: DS.attr ('number')
});
