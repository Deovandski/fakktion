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
  verifyTopicName: Ember.computed('name', function() {
    if (this.get('name').length === 0) {
      this.set('clientSideValidationComplete', false);
      return 'Cannot be empty';
    } else if (this.get('name').length < 1) {
      this.set('clientSideValidationComplete', false);
      return 'Min 1 Char.';
    } else if (this.get('name').length > 20) {
      this.set('clientSideValidationComplete', false);
      return 'Max 20 characters.';
    } else {
      if (this.model.get('topics').isAny('name', this.get('name').toLowerCase())) {
        this.set('clientSideValidationComplete', false);
        return 'This topic already exists...';
      } else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    create: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var topic = this.store.createRecord('topic', {
          name: this.get('name')
        });
        var self = this;
        topic.save().then(function() {
          self.set("application.selectedTopic", topic);
          self.set("name", "");
          self.transitionToRoute('topics');
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
