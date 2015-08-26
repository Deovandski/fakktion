import Ember from 'ember';
import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend
(AuthenticatedRouteMixin,{
	model: function()
	{
		return Ember.Object.create
		({
			genre: this.modelFor('genre'),
			genres: this.store.findAll('genre')
		});
	}
});
