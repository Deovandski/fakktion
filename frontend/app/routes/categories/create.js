import Ember from "ember";
const { service } = Ember.inject;
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin,{
  session: service('session'),
  sessionAccount: service('sessionAccount'),
  model: function() {
    return Ember.Object.create({
      category: this.modelFor('category'),
      categories: this.store.findAll('category')
    });
  }
});
