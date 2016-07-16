import Ember from "ember";
const { service } = Ember.inject;
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin,{
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  model: function() {
    return Ember.Object.create({
      topic: this.modelFor('topic'),
      topics: this.store.findAll('topic')
    });
  }
});
