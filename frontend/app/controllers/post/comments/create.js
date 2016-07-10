import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  text: "",
  clientSideValidationComplete: false,
  verifyText: Ember.computed('text', function() {
    if(this.get('text').length === 0) {
      return '';
    }
    else if(this.get('text').length < 1) {
      return 'At least 1 char.';
    }
    else if(this.get('text').length > 1000) {
      return 'At most 1000 chars.';
    }
    else {
      var charsLeft = 1000 - this.get('text').length;
      return charsLeft + ' remaining chars.';
    }
  }),
  validComment: Ember.computed('text', function() {
    if(this.get('text').length < 25) {
      this.set('clientSideValidationComplete',false);
      return false;
    }
    else if(this.get('text').length > 1000) {
      this.set('clientSideValidationComplete',false);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',true);
      return true;
    }
  }),
  actions: {
    create: function() {
      if(this.get('clientSideValidationComplete') === true) {
        var store = this.store;
        var comment = this.store.createRecord('comment', {
          post: store.peekRecord('post', this.get('model.id')),
          user: store.peekRecord('user', this.get('sessionAccount.user.id')),
          text: this.get('text'),
          empathy_level: 0
        });
        var self = this;
        comment.save().then(function() {
          self.set('text', "");
        }, function() {
          alert('Server rejected the attempt.');
        });
      }
      else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
