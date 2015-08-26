import Ember from 'ember';

export default Ember.Route.extend
({
	model: function(params)
	{
		return this.store.find('fact_type', params.factType_id);
	}
});