import DS from "ember-data";

export default DS.Model.extend
({
	user_id: DS.attr ('number'),
	genre_id: DS.attr ('number'),
	topic_id: DS.attr ('number'),
	categorie_id: DS.attr ('number'),
	fact_type_id: DS.attr ('number'),
	fact_link: DS.attr ('string'),
	fiction_link: DS.attr ('string'),
	title: DS.attr ('string'),
	importance: DS.attr ('number'),
	soft_delete: DS.attr ('boolean'),
	soft_delete_date: DS.attr ('date'),
	hidden: DS.attr ('boolean'),
	views_count: DS.attr ('number'),
	text: DS.attr ('string'),
	comments_count: DS.attr ('number')
});
