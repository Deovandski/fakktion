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
    else if(this.get('text').length < 10) {
      return 'At least 10 chars.';
    }
    else {
      return '';
    }
  }),
  validComment: Ember.computed('text', function() {
    if(this.get('text').length < 10) {
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
        var innerComment = this.store.createRecord('inner_comment', {
          comment: store.peekRecord('comment', this.get('model.id')),
          user: store.peekRecord('user', this.get('sessionAccount.user.id')),
          text: this.get('text'),
          hidden: false,
          empathy_level: 0
        });
        var self = this;
        innerComment.save().then(function() {
          self.set('text', "");
        }, function() {
          alert('failed to create comment!');
        });
      }
      else {
        alert("(Client 402) Failed to create Comment... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
