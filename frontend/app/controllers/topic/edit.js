import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
	session: service('session'),
	clientSideValidationComplete: false,
	verifyTopicName: Ember.computed('model.name', function() {
		if(this.get('model.name').length < 4) {
			if(this.get('model.name').length === 0) {
				this.set('clientSideValidationComplete',false);
				return 'Cannot be empty';
			}
			else {
				this.set('clientSideValidationComplete',false);
				return 'Too short...';
			}
		}
		else {
			var possibleTopic = this.get('topics').filterBy('name', this.get('model.name'));
			if(possibleTopic.length > 1) {
				this.set('clientSideValidationComplete',false);
				return 'This Topic Name is already in use...';
			}
			else {
				this.set('clientSideValidationComplete',true);
				return '';
			}
		}
	}),
	actions: {
		update: function() {
			if(this.get('clientSideValidationComplete') === true) {
				var topic = this.get('content');
				topic.set('name', this.get('model.name'));
				var self = this;
				topic.save().then(function() {
					self.transitionToRoute('topic', topic);
				}, function() {
					alert('(Server 402) failed to update topic... Check your input and try again!');
				});
			}
			else {
				alert("(Client 402) Failed to update topic... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
			}
		}
	}
});
