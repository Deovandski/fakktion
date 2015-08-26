import DS from "ember-data";

export default DS.Model.extend
({
	fact_link: DS.attr ('string'),
	fiction_link: DS.attr ('string'),
	title: DS.attr ('string'),
	importance: DS.attr ('number'),
	soft_delete: DS.attr ('boolean'),
	soft_delete_date: DS.attr ('date'),
	hidden: DS.attr ('boolean'),
	views_count: DS.attr ('number'),
	text: DS.attr ('string'),
	comments_count: DS.attr ('number'),
	
	// For quick search
	updated_at: DS.attr ('date'),
	created_at: DS.attr ('date'),
	genre_id: DS.attr ('number'),
	category_id: DS.attr ('number'),
	fact_type_id: DS.attr ('number'),
	topic_id: DS.attr ('number'),
	
	// Relationships
	comments: DS.hasMany('comment', {async: true}),
	user: DS.belongsTo('user', {async: true}),
	genre: DS.belongsTo('genre', {async: true}),
	fact_type: DS.belongsTo('fact_type', {async: true}),
	category: DS.belongsTo('category', {async: true}),
	topic: DS.belongsTo('topic', {async: true})
});
