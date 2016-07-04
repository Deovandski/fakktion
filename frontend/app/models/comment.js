import DS from "ember-data";

export default DS.Model.extend({
  text: DS.attr('string'),
  empathy_level: DS.attr('number'),
  updated_at: DS.attr('date'),
  created_at: DS.attr('date'),

  // Relationships
  inner_comments: DS.hasMany('inner_comment', {
    async: true
  }),
  user: DS.belongsTo('user', {
    async: true
  }),
  post: DS.belongsTo('post', {
    async: true
  })
});
