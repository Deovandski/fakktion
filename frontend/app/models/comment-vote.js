import DS from "ember-data";

export default DS.Model.extend ({
  positive_vote: DS.attr ('boolean'),
  user_id: DS.attr ('number'),
  comment_id: DS.attr ('number'),
  
  // Relationships
  user: DS.belongsTo('user', {async: true}),
  comment: DS.belongsTo('comment', {async: true})
});
