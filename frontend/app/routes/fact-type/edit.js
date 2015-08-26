import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend
(AuthenticatedRouteMixin,{
	setupController: function(controller, model)
	{
		controller.set('content', model);
        controller.set('factTypes', this.store.findAll('fact_type'));
    }
});