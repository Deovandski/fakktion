import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend
({
	ApplicationRouteMixin,
	model: function(transition, queryParams)
	{
		this._super(transition, queryParams);
		return Ember.Object.create
		({
			genres: this.store.findAll('genre'),
			factTypes: this.store.findAll('factType'),
			categories: this.store.findAll('category')
		});
	}
});
