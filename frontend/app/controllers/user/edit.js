import Ember from "ember";

export default Ember.Controller.extend
({
	actions:
	{
		updateUser: function()
		{
			var user = this.get('content');
			user.set('full_name', this.get('model.full_name'));
			var controller = this;
			user.save().then(function()
			{
				console.log('user saved!');
				controller.transitionTo('user', user);
			}, function()
			{
				alert('failed to save user!');
				
			});
		}
	}
});
