import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend
({
	ApplicationRouteMixin,
	model: function(params)
	{
		return this.store.find('post', params.post_id);
	}
});
