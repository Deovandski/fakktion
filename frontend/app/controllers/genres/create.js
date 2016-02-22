import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
	session: service('session'),
	name: "",
	clientSideValidationComplete: false,
	verifyGenreName: Ember.computed('name', function() {
		if(this.get('name').length < 4) {
			if(this.get('name').length === 0) {
				this.set('clientSideValidationComplete',false);
				return 'Cannot be empty';
			}
			else {
				this.set('clientSideValidationComplete',false);
				return 'Too short...';
			}
		}
		else {
			if(this.model.get('genres').isAny('name', this.get('name'))) {
				this.set('clientSideValidationComplete',false);
				return 'This genre Name is already in use...';
			}
			else {
				this.set('clientSideValidationComplete',true);
				return '';
			}
		}
	}),
	actions: {
		create: function() {
			if(this.get('clientSideValidationComplete') === true) {
				var genre = this.store.createRecord('genre', {
					name: this.get('name'),
				});
				var self = this;
				genre.save().then(function() {
					self.transitionToRoute('genre', genre);
				}, function() {
					alert('(Server 402) failed to create genre... Check your input and try again!');
				});
			}
			else {
				alert("(Client 402) Failed to create genre... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
			}
		}
	}
});
