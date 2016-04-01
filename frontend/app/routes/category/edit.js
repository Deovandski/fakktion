import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Route.extend ({
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  setupController: function(controller, model) {
    controller.set('content', model);
    controller.set('categories', this.store.findAll('category'));
  },
  afterModel(model, transition) {
    if (this.get('sessionAccount.user.is_admin') === true) {
      // Allow Editing
    }
    else{
      this.transitionTo('index');
    }
  }
});
