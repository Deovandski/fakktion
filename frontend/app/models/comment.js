import DS from "ember-data";

export default DS.Model.extend
({
	user_id: DS.attr ('number'),
	post_id: DS.attr ('number'),
	soft_delete: DS.attr ('boolean'),
	soft_delete_date: DS.attr ('date'),
	text: DS.attr ('string'),
	hidden: DS.attr ('boolean'),
	empathy_level: DS.attr ('number')
});
