import Ember from "ember";

export default Ember.Controller.extend
({
  actions: {
    updateUser: function() {
      var user = this.get('content');
      user.set('title', this.get('title'));
      var controller = this;
      user.save().then(function() {
        console.log('user saved!');
        controller.transitionTo('user', user);
      }, function() {
        alert('failed to save user!');
      });
    }
  }
});
