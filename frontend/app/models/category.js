import DS from "ember-data";

export default DS.Model.extend
({
	name: DS.attr ('string'),
	posts_count: DS.attr ('number'),
	posts: DS.hasMany('post', {async: true})
});
