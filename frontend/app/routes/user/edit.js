import Ember from 'ember';

export default Ember.Route.extend ({
	model: function() {
		return Ember.Object.create ({
			user: this.modelFor('user'),
			users: this.store.findAll('user')
		});
	}
});
