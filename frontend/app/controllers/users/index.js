import Ember from "ember";
const { service } = Ember.inject;

export default Ember.Controller.extend ({
  session: service('session'),
  canSelectAttribute_1: true,
  canSelectAttribute_2: true,
  searchText: "",
  underSearch: Ember.computed('searchText', 'canSelectAttribute_1','canSelectAttribute_2', function() {
    if(this.get('searchText').length > 0) {
      if(this.get('canSelectAttribute_1') === false || this.get('canSelectAttribute_2') === false){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  }),
  attrSelected: Ember.computed('canSelectAttribute_1','canSelectAttribute_2', function() {
    if (this.get('canSelectAttribute_1') === false && this.get('canSelectAttribute_2') === true){
      return "Display Name:";
    }
    else if (this.get('canSelectAttribute_1') === true && this.get('canSelectAttribute_2') === false){
      return "Email:";
    }
    else{
     return "";
    }
  }),
  filteredUsers: Ember.computed('searchText', 'canSelectAttribute_1','canSelectAttribute_2', function() {
    if(this.get('underSearch') === true){
      var rx = new RegExp(this.get('searchText').toLowerCase());
      var results = null;
      if(this.get('canSelectAttribute_1') === false) {
        results = this.model.filter(function(user) {
          return user.get('display_name').match(rx);
        });
      }
      else {
        results = this.model.filter(function(user) {
          return user.get('email').match(rx);
        });
      }
      return results;
    }
    else{
      return null;
    }
  }),
  actions: {
    setSearchAttribute: function(attr) {
      if(attr === 1){
        this.set('canSelectAttribute_1', false);
        this.set('canSelectAttribute_2', true);
      }
      else{
        this.set('canSelectAttribute_1', true);
        this.set('canSelectAttribute_2', false);
      }
    }
  }
});
