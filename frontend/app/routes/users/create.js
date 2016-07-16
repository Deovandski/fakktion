import Ember from 'ember';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';

export default Ember.Route.extend(UnauthenticatedRouteMixin, {
  model: function() {
    return Ember.Object.create({
      user: this.modelFor('user'),
      users: this.store.findAll('user')
    });
  }
});
