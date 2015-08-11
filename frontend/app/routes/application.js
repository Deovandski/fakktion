import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend
({
	ApplicationRouteMixin,
	model: function()
	{
		return Ember.Object.create
		({
			genres: this.store.findAll('genre'),
			factTypes: this.store.findAll('factType'),
			categories: this.store.findAll('category')
		});
	},
	setupController: function(controller, models)
	{
		this._super(controller, models);
	}
});
