import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  text: "",
  clientSideValidationComplete: false,
  verifyText: Ember.computed('text', function() {
    if(this.get('text').length === 0) {
      return '';
    }
    else if(this.get('text').length < 1) {
      return 'At least 1 Char.';
    }
    else if(this.get('text').length > 500) {
      return 'At most 500 chars.';
    }
    else {
      var charsLeft = 500 - this.get('text').length;
      return charsLeft + ' remaining chars.';
    }
  }),
  validComment: Ember.computed('text', function() {
    if(this.get('text').length < 25) {
      this.set('clientSideValidationComplete',false);
      return false;
    }
    else if(this.get('text').length > 500) {
      this.set('clientSideValidationComplete',false);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',true);
      return true;
    }
  }),
  anyInput: Ember.computed('text', function() {
    if(this.get('text').length > 0) {
      return true;
    }
    else {
      return false;
    }
  }),
  actions: {
    create: function() {
      if(this.get('clientSideValidationComplete') === true) {
        var store = this.store;
        var innerComment = this.store.createRecord('inner_comment', {
          comment: store.peekRecord('comment', this.get('model.id')),
          user: store.peekRecord('user', this.get('sessionAccount.user.id')),
          text: this.get('text'),
          empathy_level: 0
        });
        var self = this;
        innerComment.save().then(function() {
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
