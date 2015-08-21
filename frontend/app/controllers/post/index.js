import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	isOwner: Ember.computed('model.user_id', function()
	{
		if(this.get('session.secure.userId') === this.get('model.user_id'))
		{return true;}
		else
		{return false;}
	}),
	updatedDate: Ember.computed('model.updated_at', function()
	{
		console.log(this.get('model.genre'));
		console.log(this.get('model.genre.id'));
		console.log(this.get('model.genre.name'));
		return moment(this.get("model.updated_at")).format('L');
	}),
	createdDate: Ember.computed('model.created_at', function()
	{
		return moment(this.get("model.created_at")).format('L');
	})
});
