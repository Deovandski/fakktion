import Ember from "ember";

export default Ember.Controller.extend
({
	actions: 
	{
		authenticate: function()
		{
			//var _this = this;
			var data = this.getProperties('identification', 'password');
			return this.get('session').authenticate('simple-auth-authenticator:devise', data).then(
			function ()
			{
				/*
					Not the best way since users can login at almost any route:
					this.transitionToRoute('index'); 
					Be on the lookout for a better implementation than this:
				*/					
				window.history.go(-1);
			}, function (error)
			{
				console.log(error);
			});
		}
	}
});

