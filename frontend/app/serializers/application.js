import DS from 'ember-data';
import Ember from "ember";


export default DS.JSONAPISerializer.extend({
	keyForAttribute: function(key) {
	return Ember.String.underscore(key);
	},

	keyForRelationship: function(key) {
	return Ember.String.underscore(key);
	}
});