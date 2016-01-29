// Adapter
import DS from "ember-data";
import Ember from "ember";
import ENV from "../config/environment";

export default DS.JSONAPIAdapter.extend ({
	// Namespace.
	namespace: 'api/v1',

	// CSRF previous attempt...
	headers: Ember.computed(function(){
	var token = Ember.$('meta[name="csrf-token"]').attr('content');
	return {"X-CSRF-Token": token};
	}),

	// if your rails app is on a different port from your ember app
	// this can be helpful for development.
	// in production, the host for both rails and ember should be the same.
	host: ENV.host,

	// allows the multiword paths in urls to be underscored
	pathForType: function(type) {
		let underscored = Ember.String.underscore(type);
		return Ember.String.pluralize(underscored);
	},

	// allows queries to be sent along with a findRecord
	// hopefully Ember / EmberData will soon have this built in
	// ember-data issue tracked here:
	// https://github.com/emberjs/data/issues/3596
	urlForFindRecord(id, modelName, snapshot) {
		let url = this._super(...arguments);
		let query = Ember.get(snapshot, 'adapterOptions.query');
		if(query) {
			url += '?' + Ember.$.param(query);
		}
		return url;
	},
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
