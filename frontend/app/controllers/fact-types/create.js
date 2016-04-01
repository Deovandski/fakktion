import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  application: Ember.inject.controller('application'),
  session: service('session'),
  name: "",
  clientSideValidationComplete: false,
  verifyFactTypeName: Ember.computed('name', function() {
    if(this.get('name').length === 0) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty!';
    }
    else if(this.get('name').length > 10) {
        this.set('clientSideValidationComplete',false);
        return 'Max 10 characters.';
    }
    else {
      if(this.model.get('factTypes').isAny('name', this.get('name'))) {
        this.set('clientSideValidationComplete',false);
        return 'This fact type already exists...';
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
        var factType = this.store.createRecord('factType', {
          name: this.get('name')
        });
        var self = this;
        factType.save().then(function() {
          self.set("application.selectedFactType",factType);
          self.set("name","");
          self.transitionToRoute('index');
        }, function() {
          alert('Server Failure!');
        });
      }
      else {
        alert("Check any warning messages and try again! (Client Validation F)");
      }
    }
  }
});
