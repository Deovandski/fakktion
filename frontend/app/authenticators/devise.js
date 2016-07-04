// app/authenticators/devise.js
import Devise from 'ember-simple-auth/authenticators/devise';
import Ember from "ember";

export default Devise.extend({
  invalidate: function() {
    return Ember.$.ajax({
      url: '/users/sign_out',
      type: 'DELETE'
    });
  }
});
