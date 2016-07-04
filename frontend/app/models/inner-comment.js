import DS from "ember-data";

export default DS.Model.extend({
  text: DS.attr('string'),
  empathy_level: DS.attr('number'),
  updated_at: DS.attr('date'),
  created_at: DS.attr('date'),

  // Relationships
  user: DS.belongsTo('user', {
    async: true
  }),
  comment: DS.belongsTo('comment', {
    async: true
  })
});
