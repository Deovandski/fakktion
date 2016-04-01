import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  sessionAccount: service('session-account'),
  clientSideValidationComplete: false,
  verifyCategoryName: Ember.computed('model.name', function(){
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
      var possibleCategory = this.get('categories').filterBy('name', this.get('model.name'));
      if(possibleCategory.length > 1) {
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
        var category = this.get('content');
        category.set('name', this.get('model.name'));
        var self = this;
        category.save().then(function(){
          self.transitionToRoute('category', category);
        }, function(){
          alert('(Server 402) failed to update genre.');
        });
      }
      else{
        alert("(Client 402) Failed to update genre.");
      }
    }
  }
});
