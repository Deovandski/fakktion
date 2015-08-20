import Ember from "ember";

export default Ember.Controller.extend
({
	actions:
	{
		updatePost: function()
		{
			var post = this.get('content');
			post.set('title', this.get('title'));
			var controller = this;
			post.save().then(function()
			{
				console.log('post saved!');
				controller.transitionToRoute('post', post);
			}, function()
			{
				alert('failed to save post!');
			});
		}
	}
});
