import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  name: "",
  clientSideValidationComplete: false,
  verifyFactTypeName: Ember.computed('name', function() {
    if(this.get('name').length < 4) {
      if(this.get('name').length === 0) {
        this.set('clientSideValidationComplete',false);
        return 'Cannot be empty';
      }
      else {
        this.set('clientSideValidationComplete',false);
        return 'Too short...';
      }
    }
    else {
      if(this.model.get('factTypes').isAny('name', this.get('name'))) {
        this.set('clientSideValidationComplete',false);
        return 'This Fact Type Name is already in use...';
      }
      else {
        this.set('clientSideValidationComplete',true);
        return '';
      }
    }
  }),
  actions: {
    create: function() {
      if(this.get('clientSideValidationComplete') === true) {
        var factType = this.store.createRecord('fact_type', {
          name: this.get('name');
        });
        var self = this; // Controller instance for route transitioning.
        factType.save().then(function() {
          self.transitionToRoute('index');
        }, function() {
          alert('(Server 402) failed to create User... Check your input and try again!');
        });
      }
      else {
        alert("(Client 402) Failed to create Fact Type... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
