import DS from "ember-data";

export default DS.Model.extend({
  softDelete: DS.attr ('boolean'),
  softDeleteDate: DS.attr ('date'),
  text: DS.attr ('string'),
  hidden: DS.attr ('boolean'),
  empathyLevel: DS.attr ('number')
});
