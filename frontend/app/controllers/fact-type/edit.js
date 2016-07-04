import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  session: service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  verifyFactTypeName: Ember.computed('model.name', function() {
    if (this.get('model.name').length === 0) {
      this.set('clientSideValidationComplete', false);
      return 'Cannot be empty';
    } else if (this.get('model.name').length < 4) {
      this.set('clientSideValidationComplete', false);
      return 'Min 4 characters.';
    } else if (this.get('model.name').length > 15) {
      this.set('clientSideValidationComplete', false);
      return 'Max 15 characters.';
    } else {
      var possibleFactType = this.get('factTypes').filterBy('name', this.get('model.name').toLowerCase());
      if (possibleFactType.length > 1) {
        this.set('clientSideValidationComplete', false);
        return 'This genre model.name is already in use...';
      } else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    cancelChanges: function() {
      this.get('model').rollbackAttributes();
      this.transitionToRoute('factType', this.get('model'));
    },
    update: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var factType = this.get('content');
        factType.set('name', this.get('model.name'));
        var self = this;
        factType.save().then(function() {
          self.transitionToRoute('factType', factType);
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
