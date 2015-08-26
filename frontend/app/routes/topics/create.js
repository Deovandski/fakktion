import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend
(AuthenticatedRouteMixin,{
	model: function()
	{
		return Ember.Object.create
		({
			topic: this.modelFor('topic'),
			topics: this.store.findAll('topic')
		});
	}
});
