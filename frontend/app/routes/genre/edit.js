import Ember from 'ember';

export default Ember.Route.extend ({
	setupController: function(controller, model) {
		controller.set('content', model);
        controller.set('genres', this.store.findAll('genre'));
    }
});
