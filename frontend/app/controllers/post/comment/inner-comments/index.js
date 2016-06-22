import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  innerCommentSortProperties: ['empathy_level:desc'],
  sortedInnerComments: Ember.computed.sort('model.inner_comments', 'innerCommentSortProperties'),
  isBanned: Ember.computed('sessionAccount.user.reputation', function() {
    if(this.get('sessionAccount.user.reputation') < -200){
      return true;
    }
    else{
      return false;
    }
  }),
});
