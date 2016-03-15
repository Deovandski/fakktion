import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  clientSideValidationComplete: false,
  verifyGenreName: Ember.computed('model.name', function(){
    if(this.get('model.name').length < 4){
      if(this.get('model.name').length === 0){
        this.set('clientSideValidationComplete',false);
        return 'Cannot be empty';
      }
      else{
        this.set('clientSideValidationComplete',false);
        return 'Too short...';
      }
    }
    else{
      var possibleGenre = this.get('genres').filterBy('name', this.get('model.name'));
      if(possibleGenre.length > 1) {
        this.set('clientSideValidationComplete',false);
        return 'This genre model.name is already in use...';
      }
      else{
        this.set('clientSideValidationComplete',true);
        return '';
      }
    }
  }),
  actions: {
    update: function() {
      if(this.get('clientSideValidationComplete') === true){
        var genre = this.get('content');
        genre.set('name', this.get('model.name'));
        var self = this;
        genre.save().then(function(){
          self.transitionToRoute('genre', genre);
        }, function(){
          alert('(Server 402) failed to update genre... Check your input and try again!');
        });
      }
      else{
        alert("(Client 402) Failed to update genre... Check any warning messages (to the right of each textbox) otherwise contact support if you don't see any");
      }
    }
  }
});
