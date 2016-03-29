import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  application: Ember.inject.controller('application'),
  session: service('session'),
  name: "",
  clientSideValidationComplete: false,
  verifyTopicName: Ember.computed('name', function() {
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
    else if(this.get('name').length > 15) {
        this.set('clientSideValidationComplete',false);
        return 'Max 15 characters.';
    }
    else {
      if(this.model.get('topics').isAny('name', this.get('name'))) {
        this.set('clientSideValidationComplete',false);
        return 'This Topic Name is already in use...';
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
        var store = this.store;
        var topic = store.createRecord('topic', {
          name: this.get('name')
        });
        var self = this;
        topic.save().then(function() {
          self.set("application.selectedTopic",topic);
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
