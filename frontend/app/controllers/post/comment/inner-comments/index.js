import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  innerCommentSortProperties: ['empathy_level:desc'],
  sortedInnerComments: Ember.computed.sort('model.inner_comments', 'innerCommentSortProperties')
});
