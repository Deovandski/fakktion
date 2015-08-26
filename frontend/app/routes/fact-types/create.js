import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend
(AuthenticatedRouteMixin,{
	model: function()
	{
		return Ember.Object.create
		({
			factType: this.modelFor('fact_type'),
			factTypes: this.store.findAll('fact_type')
		});
	}
});
