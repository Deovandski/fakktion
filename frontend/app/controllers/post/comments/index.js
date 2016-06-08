import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  commentSortProperties: ['empathy_level:desc'],
  sortedComments: Ember.computed.sort('model.comments', 'commentSortProperties'),
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if(this.get('sessionAccount.user.reputation') < -500){
      return true;
    }
    else{
      return false;
    }
  })
});
