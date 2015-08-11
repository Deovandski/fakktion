import Ember from 'ember';
 
export default Ember.Route.extend
({
	model: function()
	{
		return Ember.Object.create
		({
			posts: this.store.findAll('post')
		});
	}
});
