import Ember from 'ember';

export default Ember.Route.extend ({
	model: function() {
		return Ember.Object.create ({
			topic: this.modelFor('topic'),
			topics: this.store.findAll('topic')
		});
	}
});
