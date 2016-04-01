import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  application: Ember.inject.controller('application'),
  session: service('session'),
  name: "",
  clientSideValidationComplete: false,
  verifyTopicName: Ember.computed('name', function() {
    if(this.get('name').length === 0) {
      this.set('clientSideValidationComplete',false);
      return 'Cannot be empty!';
    }
    else if(this.get('name').length > 20) {
        this.set('clientSideValidationComplete',false);
        return 'Max 20 characters.';
    }
    else {
      if(this.model.get('topics').isAny('name', this.get('name'))) {
        this.set('clientSideValidationComplete',false);
        return 'This topic already exists...';
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
        var topic = this.store.createRecord('topic', {
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
