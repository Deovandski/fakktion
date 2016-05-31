import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  commentSortProperties: ['empathy_level:desc'],
  sortedComments: Ember.computed.sort('model.comments', 'commentSortProperties')
});
