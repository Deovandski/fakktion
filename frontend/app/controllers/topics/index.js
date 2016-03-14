import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
	session: service('session'),
	application: Ember.inject.controller('application'),
	filteredTopics: Ember.computed('application.topicInputText', function() {
		if(this.get('application.topicInputText') === '') {
			return this.model;
		}
		else{
			var rx = new RegExp(this.get('application.topicInputText').toLowerCase()
			);
			var countries = this.get('arrangedContent');

			return this.model.filter(function(topic) {
			  return topic.get('name').match(rx);
			});
		}
	}),
	actions: {
		setTopic: function(topic) {
			this.set('application.selectedTID', topic.id);
			this.set('application.selectedTN', topic.get('name'));
			this.set('application.topicInputText', topic.get('name'));
		}
	}
});
