import DS from "ember-data";

export default DS.Model.extend ({
  text: DS.attr ('string'),
  hidden: DS.attr ('boolean'),
  empathy_level: DS.attr ('number'),
  
  // Relationships
  inner_comments: DS.hasMany('inner_comment', {async: true}),
  user: DS.belongsTo('user', {async: true}),
  post: DS.belongsTo('post', {async: true})
});
