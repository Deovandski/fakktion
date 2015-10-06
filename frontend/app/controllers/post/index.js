import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	application: Ember.inject.controller('application'),
	notExpandInfo: true,
	canEdit: Ember.computed('model.user_id','application.isSuperUser', 'application.isAdmin', function()
	{
		if(this.get('session.secure.userId') === this.get('model.user_id')){
			return true;
		}
		else if(this.get('application.isSuperUser') === true) {
			return true;
		}
		else if(this.get('application.isAdmin') === true) {
			return true;
		}
		else {
			return false;
		}
	}),
	updatedDate: Ember.computed('model.updated_at', function()
	{
		console.log(this.get('model.comments'));
		console.log(this.get('model.comments.length'));
		return moment(this.get("model.updated_at")).format('L');
	}),
	createdDate: Ember.computed('model.created_at', function()
	{
		return moment(this.get("model.created_at")).format('L');
	}),
	actions: {
		//Set ID Tag Methods
		setNotExpandInfo: function(expandInfo) { 
			this.set('notExpandInfo', expandInfo);
		}
	}
});
