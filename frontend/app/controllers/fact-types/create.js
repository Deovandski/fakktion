import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  application: Ember.inject.controller('application'),
  session: service('session'),
  sessionAccount: service('session-account'),
  name: "",
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if (this.get('sessionAccount.user.reputation') < -100) {
      return true;
    } else {
      return false;
    }
  }),
  clientSideValidationComplete: false,
  verifyFactTypeName: Ember.computed('name', function() {
    if (this.get('name').length === 0) {
      this.set('clientSideValidationComplete', false);
      return 'Cannot be empty';
    } else if (this.get('name').length < 1) {
      this.set('clientSideValidationComplete', false);
      return 'Min 1 characters.';
    } else if (this.get('name').length > 15) {
      this.set('clientSideValidationComplete', false);
      return 'Max 15 characters.';
    } else {

      if (this.model.get('factTypes').isAny('name', this.get('name').toLowerCase())) {
        this.set('clientSideValidationComplete', false);
        return 'This fact type already exists...';
      } else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    create: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var factType = this.store.createRecord('factType', {
          name: this.get('name')
        });
        var self = this;
        factType.save().then(function() {
          self.set("application.selectedFactType", factType);
          self.set("name", "");
          self.transitionToRoute('factTypes');
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
