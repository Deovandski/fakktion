import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend({
  session: service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  verifyGenreName: Ember.computed('model.name', function() {
    if (this.get('model.name').length === 0) {
      this.set('clientSideValidationComplete', false);
      return 'Cannot be empty';
    } else if (this.get('model.name').length < 4) {
      this.set('clientSideValidationComplete', false);
      return 'Min 4 characters.';
    } else if (this.get('model.name').length > 15) {
      this.set('clientSideValidationComplete', false);
      return 'Max 15 characters.';
    } else {
      var possibleGenre = this.get('genres').filterBy('name', this.get('model.name').toLowerCase());
      if (possibleGenre.length > 1) {
        this.set('clientSideValidationComplete', false);
        return 'This genre already exists.';
      } else {
        this.set('clientSideValidationComplete', true);
        return '';
      }
    }
  }),
  actions: {
    cancelChanges: function() {
      this.get('model').rollbackAttributes();
      this.transitionToRoute('genre', this.get('model'));
    },
    update: function() {
      if (this.get('clientSideValidationComplete') === true) {
        var genre = this.get('content');
        genre.set('name', this.get('model.name'));
        var self = this;
        genre.save().then(function() {
          self.transitionToRoute('genre', genre);
        }, function() {
          alert('Server rejected the attempt.');
        });
      } else {
        alert("Please check any outstanding warning message(s), and try again!");
      }
    }
  }
});
