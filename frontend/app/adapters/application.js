import DS from "ember-data";
import Ember from "ember";
import $ from 'jquery';
var token = $('meta[name="csrf-token"]').attr('content');
DS.RESTAdapter.reopen({
    headers: {
        "X-CSRF-Token": token
    }
});
export default DS.RESTAdapter.extend
({
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
