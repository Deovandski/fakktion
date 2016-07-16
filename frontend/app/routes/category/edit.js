import Ember from "ember";
const { service } = Ember.inject;
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin,{
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  setupController: function(controller, model) {
    controller.set('content', model);
    controller.set('categories', this.store.findAll('category'));
  },
  afterModel() {
    if (this.get('sessionAccount.user.is_admin') === true) {
      // Allow Editing
    } else {
      this.transitionTo('index');
    }
  }
});
