import DS from "ember-data";

export default DS.Model.extend ({
  email: DS.attr ('string'),
  authenticity_token: DS.attr ('string')
});
