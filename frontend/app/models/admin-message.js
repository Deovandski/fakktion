/* SEE ISSUE #31
import DS from "ember-data";

export default DS.Model.extend ({
  title: DS.attr ('string'),
  message: DS.attr ('string'),

  // Relationships
  user: DS.belongsTo('user', {async: true})
});
*/
