import DS from "ember-data";

export default DS.Model.extend ({
  positivite_vote: DS.attr ('boolean'),
  
  // Relationships
  user: DS.belongsTo('user', {async: true}),
  comment: DS.belongsTo('comment', {async: true})
});
