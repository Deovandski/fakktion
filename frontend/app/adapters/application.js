// Adapter
import DS from "ember-data";
import Ember from "ember";

export default DS.JSONAPIAdapter.extend ({
	namespace: 'api/v1',
	headers: Ember.computed(function(){
	var token = Ember.$('meta[name="csrf-token"]').attr('content');

	return {"X-CSRF-Token": token};
	}),
	pathForType: function(type) {
		var underscored = Ember.String.underscore(type);
		return Ember.String.pluralize(underscored);
	},
	shouldReloadAll() {
		return true;
	},
	shouldBackgroundReloadRecord() {
		return true;
	}
});
