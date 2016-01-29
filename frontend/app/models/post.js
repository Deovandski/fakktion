import DS from "ember-data";

export default DS.Model.extend ({
	fact_link: DS.attr ('string'),
	fiction_link: DS.attr ('string'),
	title: DS.attr ('string'),
	importance: DS.attr ('number'),
	soft_delete: DS.attr ('boolean'),
	soft_delete_date: DS.attr ('date'),
	hidden: DS.attr ('boolean'),
	views_count: DS.attr ('number'),
	text: DS.attr ('string'),
	updated_at: DS.attr ('date'),
	created_at: DS.attr ('date'),
	comments_count: DS.attr ('number'),
	
	// Relationships
	comments: DS.hasMany('comment', {async: true}),
	user: DS.belongsTo('user'),
	genre: DS.belongsTo('genre'),
	fact_type: DS.belongsTo('fact_type'),
	category: DS.belongsTo('category'),
	topic: DS.belongsTo('topic')
});
