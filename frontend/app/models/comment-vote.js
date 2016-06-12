import DS from "ember-data";

export default DS.Model.extend ({
  positive_vote: DS.attr ('boolean'),
  recorded_vote: DS.attr ('number'),
  
  // Used for Quickly filtering through records when finding user vote. See index controller for more info.
  user_id: DS.attr ('number'),
  comment_id: DS.attr ('number'),
  
  // Relationships
  user: DS.belongsTo('user', {async: false}),
  comment: DS.belongsTo('comment', {async: false})
});
