import Ember from "ember";
import moment from 'moment';
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  expandInfo: false,
  verifyFacebookURL: Ember.computed('model.facebook_url', function() {
    if(this.get('model.facebook_url') !== '') {
      if(this.get('model.facebook_url').indexOf("facebook") !== -1)
      {return true;}
      else
      {return false;}
    }
    else
    {return false;}
  }),
  verifyTwitterURL: Ember.computed('model.twitter_url', function() {
    if(this.get('model.twitter_url') !== '') {
      if(this.get('model.twitter_url').indexOf("twitter") !== -1)
      {return true;}
      else
      {return false;}
    }
    else
    {return false;}
  }),
  verifyWebpageURL: Ember.computed('model.webpage_url', function() {
    if(this.get('model.webpage_url') !== '')
    {return true;}
    else
    {return false;}
  }),
  verifyPosts: Ember.computed('model.posts_count', function() {
    if(this.get('model.posts_count') === 0)
    {return false;}
    else
    {return true;}
  }),
  verifyComments: Ember.computed('model.comments_count', function() {
    if(this.get('model.comments_count') === 0)
    {return false;}
    else
    {return true;}
  }),
  isOwner: Ember.computed('model.id', function() {
    if(this.get('sessionAccount.user.email') === this.get('model.email'))
    {return true;}
    else
    {return false;}
  }),
  ageDate: Ember.computed('model.date_of_birth', function() {
    var currentDate= moment();
    var tempDate = moment(this.get("model.date_of_birth"));
    var age = currentDate.diff(tempDate, 'years');
    return age;
  }),
  updatedDate: Ember.computed('model.updated_at', function() {
    return moment(this.get("model.updated_at")).format('L');
  }),
  createdDate: Ember.computed('model.created_at', function() {
    return moment(this.get("model.created_at")).format('L');
  }),
  actions: {
    setExpandInfo: function(boolean) {
      this.set('expandInfo', boolean);
    }
  }
});
