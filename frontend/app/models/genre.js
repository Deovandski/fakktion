import DS from "ember-data";

export default DS.Model.extend ({
	name: DS.attr ('string'),
	posts_count: DS.attr ('number'),
	eligibility_counter: DS.attr ('number'),
	
	// Relationships
	posts: DS.hasMany('post')
});
