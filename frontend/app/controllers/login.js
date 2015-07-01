import Ember from "ember";

export default Ember.Controller.extend
({
	actions: 
	{
		authenticate: function()
		{
         var _this = this;
			var data = this.getProperties('identification', 'password');
			return this.get('session').authenticate('simple-auth-authenticator:devise', data).then(null, function(error)
			{
				var message = error.error;
				_this.set('errorMessage', message);
			});
		}
	}
});
