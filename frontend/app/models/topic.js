import DS from "ember-data";

export default DS.Model.extend
({
	name: DS.attr ('string'),
	usage_count: DS.attr ('number')
});
