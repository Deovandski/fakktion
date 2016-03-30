import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  editMode: false,
  verifyText: Ember.computed('model.text', function() {
    if(this.get('model.text').length === 0) {
      return '';
    }
    else if(this.get('model.text').length < 10) {
      return 'At least 10 chars.';
    }
    else {
      return '';
    }
  }),
  validComment: Ember.computed('model.text', function() {
    if(this.get('model.text').length < 10) {
      this.set('clientSideValidationComplete',false);
      return false;
    }
    else {
      this.set('clientSideValidationComplete',true);
      return true;
    }
  }),
  canEdit: Ember.computed('sessionAccount', function() {
    console.log('InnerC UserID: ' + this.get('model.user.id'));
    if(this.get('model.user.id') === this.get('sessionAccount.user.id') && this.get('model.user.id') !== undefined) {
      return true;
    }
    else {
      return false;
    }
  }),
  actions: {
    ToggleEditMode: function() {
      if(this.get('canEdit') === true){
        if(this.get('editMode') === true){
          this.set('editMode', false);
        }
        else{
          this.set('editMode', true);
        }
      }
      else{
        this.set('editMode', false);
      }
    },
    update: function() {
      if(this.get('clientSideValidationComplete') === true) {
        this.get('model').save().then(() => {
          this.set('editMode', false);
        }).catch((reason) => {
          console.log(reason);
          alert('Inner Comment Not Updated!');
        });
      }
      else {
        alert("(Client 402) Failed to create Inner Comment... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
