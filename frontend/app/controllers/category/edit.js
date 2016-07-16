import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  session: service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  verifyCategoryName: Ember.computed('model.name', function() {
    if (this.get('model.name').length === 0) {
      this.set('clientSideValidationComplete', false);
      return 'Cannot be empty';
    } else if (this.get('model.name').length < 1) {
      this.set('clientSideValidationComplete', false);
      return 'Min 1 characters.';
    } else if (this.get('model.name').length > 15) {
      this.set('clientSideValidationComplete', false);
      return 'Max 15 characters.';
    } else {
      var possibleCategory = this.get('categories').filterBy('name', this.get('model.name').toLowerCase());
      if (possibleCategory.length > 1) {
        this.set('clientSideValidationComplete', false);
        return 'This genre model.name is already in use...';
      } else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    cancelChanges: function() {
      this.get('model').rollbackAttributes();
      this.transitionToRoute('category', this.get('model'));
    },
    update: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var category = this.get('content');
        category.set('name', this.get('model.name'));
        var self = this;
        category.save().then(function() {
          self.transitionToRoute('category', category);
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
