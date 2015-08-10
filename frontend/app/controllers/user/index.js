import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	verifyPosts: Ember.computed('model.posts.length', function()
	{
		if(this.get('model.posts').length < 1)
		{
			return false;
		}
		else
		{
			return true;
		}
	}),
	verifyComments: Ember.computed('model.comments.length', function()
	{
		if(this.get('model.comments').length < 1)
		{
			return false;
		}
		else
		{
			return true;
		}
	}),
	isOwner: Ember.computed('model.id', function()
	{
		//console.log(this.get('session.secure.userId'));
		//console.log(this.get('session.secure.email'));
		if(this.get('session.secure.email') === this.get('model.email'))
		{
			return true;
		}
		else
		{
			return false;
		}
	}),
	ageDate: Ember.computed('model.date_of_birth', function()
	{
		var currentDate= moment();
		var tempDate= moment(this.get("model.date_of_birth"));
		var age= currentDate.diff(tempDate, 'years');
		return age;
	}),
	updatedDate: Ember.computed('model.updated_at', function()
	{
		return moment(this.get("model.updated_at")).format('L');
	}),
	createdDate: Ember.computed('model.created_at', function()
	{
		return moment(this.get("model.created_at")).format('L');
	})
});
