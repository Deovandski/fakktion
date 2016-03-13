import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Route.extend ({
	session: service('session'),
	sessionAccount: service('session-account'),
	model: function() {
		return Ember.Object.create ({
			user: this.modelFor('user'),
			users: this.store.findAll('user')
		});
	},
	afterModel(model, transition) {
		if (model.user.get('id') === this.get('sessionAccount.user.id')) {
			// Do Nothing
		}
		else{
			if(this.get('sessionAccount.user.is_super_user')){
				//Do nothing
			}
			else{
			this.transitionTo('index');
			}
		}
	}
});
