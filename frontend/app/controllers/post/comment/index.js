import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session:        service('session'),
  sessionAccount: service('session-account'),
  application: Ember.inject.controller('application'),
  clientSideValidationComplete: false,
  editMode: false,
  upvoteEnabled: false,
  downvoteEnabled: false,
  didUserVote: false,
  votingID: -1,
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if(this.get('sessionAccount.user.reputation') < -500){
      return true;
    }
    else{
      return false;
    }
  }),
  createdDate: Ember.computed('model.created_at', function() {
    return moment(this.get("model.created_at")).format('L');
  }),
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

        // Allow the opposite vote to be cast by the non author user.
        if (self.get('sessionAccount.user.id') === self.get('model.user.id')){
          self.set('upvoteEnabled',false);
          self.set('downvoteEnabled',false);
        }
        else if(self.get('isBanned') === true){
          self.set('upvoteEnabled',false);
          self.set('downvoteEnabled',false);
        }
        else if (possibleVote === undefined){
          self.set('upvoteEnabled',true);
          self.set('downvoteEnabled',true);
        }
        else if (possibleVote.get('positive_vote') === true){
          self.set('downvoteEnabled',true);
          self.set('didUserVote',true);
          self.set('votingID',possibleVote.get('id'));
        }
        else if (possibleVote.get('positive_vote') === false){
          self.set('upvoteEnabled',true);
          self.set('didUserVote',true);
          self.set('votingID',possibleVote.get('id'));
        }
      });
    }
  }),
  verifyText: Ember.computed('model.text', function() {
    if(this.get('model.text').length < 1) {
      this.set('clientSideValidationComplete',false);
      return "1 Min Character...";
    }
    else if(this.get('model.text').length > 1000) {
      this.set('clientSideValidationComplete',false);
      return "1000 Max Characters!!!";
    }
    else {
      this.set('clientSideValidationComplete',true);
      var charsLeft = 1000 - this.get('model.text').length;
      return charsLeft + ' Characters left.';
    }
  }),
  validComment: Ember.computed('model.text', function() {
    if(this.get('model.text').length < 10) {
      this.set('clientSideValidationComplete',false);
      return false;
    }
    else if(this.get('model.text').length > 1000) {
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
          this.get('model').rollbackAttributes();
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
    castVote: function(userVote){
      this.set('userVote', userVote);
      // Update Voting record
      if(this.get('didUserVote') === true){
        var self = this; // Controller instance for maniupulation with then()
        var voteRequest = this.get('store').findRecord('commentVote', parseInt(self.get('votingID'))).then(function(request) {
          if (request.get('positive_vote') === true){
            request.positive_vote = false;
          }
          else{
            request.positive_vote = true;
          }
          request.save().then(() => {
            console.log('Vote was updated');
            if(self.get('userVote') === true){
              self.set('upvoteEnabled',false);
              self.set('downvoteEnabled',true);
            }
            else{
              self.set('upvoteEnabled',true);
              self.set('downvoteEnabled',false);
            }
            self.get('model').reload();
          }).catch((reason) => {
            console.log(reason);
          });
        });
        voteRequest = null;
      }
      // Create a new voting record
      else{
        var votePromise = new Ember.RSVP.Promise((resolve) => {
          var voteRequest = this.get('store').createRecord('commentVote', {
            user: this.store.peekRecord('user', this.get('sessionAccount.user.id')),
            comment: this.store.peekRecord('comment', this.get('model.id')),
            positive_vote: this.userVote
          });
          var self = this; // Controller instance for maniupulation with then()
          voteRequest.save().then((record) => {
            if(self.get('userVote') === true){
              self.set('upvoteEnabled',false);
              self.set('downvoteEnabled',true);
            }
            else{
              self.set('upvoteEnabled',true);
              self.set('downvoteEnabled',false);
            }
            self.get('model').reload();
            self.set('didUserVote', true);
            self.set('votingID',record.get('id'));
          }).catch((reason) => {
            console.log(reason);
            resolve();
          });
        });
        votePromise = null;
      }
    },
    update: function() {
      if(this.get('clientSideValidationComplete') === true) {
        this.get('model').save().then(() => {
          this.set('editMode', false);
        }).catch((reason) => {
          console.log(reason);
          alert('Server rejected the attempt.');
        });
      }
      else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
