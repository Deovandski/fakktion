import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  name: "",
  clientSideValidationComplete: false,
  verifyFactTypeName: Ember.computed('model.name', function() {
    if(this.get('model.name').length < 4) {
      if(this.get('model.name').length === 0) {
        this.set('clientSideValidationComplete',false);
        return 'Cannot be empty';
      }
      else {
        this.set('clientSideValidationComplete',false);
        return 'Too short...';
      }
    }
    else {
      var possibleFactType = this.get('factTypes').filterBy('name', this.get('model.name'));
      if(possibleFactType.length > 1) {
        this.set('clientSideValidationComplete', false);
        return 'This factType Name is already in use...';
      }
      else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    update: function() {
      if(this.get('clientSideValidationComplete') === true) {
        var factType = this.get('content');
        factType.set('name', this.get('model.name'));
        var self = this;
        factType.save().then(function() {
          self.transitionToRoute('factType', factType);
        }, function() {
          alert('(Server 402) failed to update Fact Type... Check your input and try again!');
        });
      }
      else {
        alert("(Client 402) Failed to update Fact Type... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
