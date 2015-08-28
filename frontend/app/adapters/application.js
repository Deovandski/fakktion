import DS from "ember-data";
import Ember from "ember";
import $ from 'jquery';

export default DS.JSONAPIAdapter.extend
({
	namespace: 'api/v1',
	headers: {
		"X-CSRF-Token": $('meta[name="csrf-token"]').attr('content')
	},
	pathForType: function(type) {
		var underscored = Ember.String.underscore(type);
		return Ember.String.pluralize(underscored);
	},
	shouldReloadAll() {
		return true;
	},
	shouldBackgroundReloadRecord(){
		return true;
	}
});
