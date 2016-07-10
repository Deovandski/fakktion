import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  session: service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  verifyTopicName: Ember.computed('model.name', function() {
    if (this.get('model.name').length === 0) {
      this.set('clientSideValidationComplete', false);
      return 'Cannot be empty';
    } else if (this.get('model.name').length < 1) {
      this.set('clientSideValidationComplete', false);
      return 'Min 1 Char.';
    } else if (this.get('model.name').length > 20) {
      this.set('clientSideValidationComplete', false);
      return 'Max 20 characters.';
    } else {
      var possibleTopic = this.get('topics').filterBy('name', this.get('model.name').toLowerCase());
      if (possibleTopic.length > 1) {
        this.set('clientSideValidationComplete', false);
        return 'This Topic already exists!';
      } else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    cancelChanges: function() {
      this.get('model').rollbackAttributes();
      this.transitionToRoute('topic', this.get('model'));
    },
    update: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var topic = this.get('content');
        topic.set('name', this.get('model.name'));
        var self = this;
        topic.save().then(function() {
          self.transitionToRoute('topic', topic);
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
