import Ember from 'ember';

export default Ember.Route.extend
({
	/* Not Working.... Maybe it will on Ember 2.0
	renderTemplate: function() {
	var controller = this.controllerFor('CommentsCreate');
	this.render('CommentsCreate', {
	  outlet: 'addComment',
	  controller: controller
	});
	},
	*/
	model: function(params)
	{
		return this.store.find('post', params.post_id);
	}
});
