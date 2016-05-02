import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  editMode: false,
  upvoteEnabled: false,
  downvoteEnabled: false,
  didUserVote: false,
  // Setup for initial allowed votings by the logged in User.
  votingSystemHandler: Ember.computed('sessionAccount.user.id', function() {
    if(this.get('sessionAccount.user.id') > 0){
      
      var self = this; // Controller instance for maniupulation with then()
      // QueryRecord not working, using filter on clientside as a fallback...
      this.store.findAll('commentVote').then(function(possibleVotes) {
        possibleVotes = possibleVotes.filter(function(possibleVote) {
          if (possibleVote.get('user_id') === parseInt(self.get('sessionAccount.user.id')) && possibleVote.get('comment_id') === parseInt(self.get('model.id'))){
            return possibleVote;
          }
        });
        var possibleVote = possibleVotes.objectAt(0);
        
        console.log(possibleVote.get('positive_vote'));
        // Allow the opposite vote to be cast by the user.
        if (possibleVote.get('positive_vote') === true){
            self.set('downvoteEnabled',true);
        }
        else if (possibleVote.get('positive_vote') === false){
            self.set('upvoteEnabled',true);
        }
        else{
          self.set('upvoteEnabled',true);
          self.set('downvoteEnabled',true);
        }
      });
    };
  }),
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
  canEdit: Ember.computed('sessionAccount.user.id', function() {
    if(this.get('model.user.id') > 0){
      if(this.get('model.user.id') === this.get('sessionAccount.user.id')) {
        return true;
      }
      else {
        return false;
      }
    }
    else{
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
    upvote: function(){
      var upvotePromise = new Ember.RSVP.Promise((resolve) => {
        var upvoteRequest = this.get('store').createRecord('commentVote', {
          user: this.store.peekRecord('user', this.get('sessionAccount.user.id')),
          comment: this.store.peekRecord('comment', this.get('model.id')),
          positive_vote: true
        });
        upvoteRequest.save().then(() => {
          console.log('Vote was accepted');
          this.get('model').reload();
          this.set('upvoteEnabled',false);
          resolve();
        }).catch((reason) => {
          console.log(reason);
          resolve();
        });
      });
      upvotePromise = null;
    },
    downvote: function(){
      var downvotePromise = new Ember.RSVP.Promise((resolve) => {
        var downvoteRequest = this.get('store').createRecord('commentVote', {
          user: this.store.peekRecord('user', this.get('sessionAccount.user.id')),
          comment: this.store.peekRecord('comment', this.get('model.id')),
          positive_vote: false
        });
        downvoteRequest.save().then(() => {
          console.log('Vote was accepted');
          this.get('model').reload();
          this.set('downvoteEnabled',false);
          resolve();
        }).catch((reason) => {
          console.log(reason);
          resolve();
        });
      });
      downvotePromise = null;
    },
    update: function() {
      if(this.get('clientSideValidationComplete') === true) {
        this.get('model').save().then(() => {
          this.set('editMode', false);
        }).catch((reason) => {
          console.log(reason);
          alert('Comment Not Updated!');
        });
      }
      else {
        alert("(Client 402) Failed to create Comment... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
