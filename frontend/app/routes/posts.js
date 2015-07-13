import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend
({
	ApplicationRouteMixin,
	model: function()
	{
		return Ember.Object.create
		({
         posts: this.store.findAll('post')
		});
	}
});
