import DS from "ember-data";

export default DS.Model.extend ({
  fact_link: DS.attr ('string'),
  fiction_link: DS.attr ('string'),
  title: DS.attr ('string'),
  hidden: DS.attr ('boolean'),
  views_count: DS.attr ('number'),
  text: DS.attr ('string'),
  updated_at: DS.attr ('date'),
  created_at: DS.attr ('date'),
  comments_count: DS.attr ('number'),
  // Index filter purposes... See Ember Data #1865
  user_id: DS.attr ('number'),
  genre_id: DS.attr ('number'),
  topic_id: DS.attr ('number'),
  category_id: DS.attr ('number'),
  fact_type_id: DS.attr ('number'),
  
  // Relationships
  comments: DS.hasMany('comment', {async: true}),
  user: DS.belongsTo('user'),
  genre: DS.belongsTo('genre'),
  fact_type: DS.belongsTo('fact_type'),
  category: DS.belongsTo('category'),
  topic: DS.belongsTo('topic')
});
