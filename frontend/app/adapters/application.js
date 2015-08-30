import DS from "ember-data";
import Ember from "ember";
import $ from 'jquery';

var token = $('meta[name="csrf-token"]').attr('content');
export default DS.JSONAPIAdapter.extend
({
    headers: {
        "X-CSRF-Token": token
    },
	namespace: 'api/v1',
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
