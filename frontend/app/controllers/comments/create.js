import Ember from "ember";

export default Ember.Controller.extend ({
	application: Ember.inject.controller('application'),
	text: "",
	clientSideValidationComplete: false,
	verifyText: Ember.computed('text', function() {
		if(this.get('text').length < 10) {
			this.set('clientSideValidationComplete',false);
			return 'Cannot be empty';
		}
		else {
			this.set('clientSideValidationComplete',true);
			return '';
		}
	}),
	validComment: Ember.computed('text', function() {
		if(this.get('text').length < 10) {
			return false;
		}
		else {
			return true;
		}
	}),
	actions: {
		create: function() {
			if(this.get('clientSideValidationComplete') === true) {
				var store = this.store;
				var comment = this.store.createRecord('comment', {
					post: store.peekRecord('post', this.get('model.id')),
					user: store.peekRecord('user', this.get('session.secure.userId')),
					text: this.get('text'),
					hidden: false,
					empathy_level: 0,
				});
				var self = this;
				comment.save().then(function() {
					self.model.reload();
					self.transitionToRoute('post');
				}, function() {
					alert('failed to create comment!');
				});
			}
			else {
				alert("(Client 402) Failed to create Comment... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
			}
		}
	}
});
