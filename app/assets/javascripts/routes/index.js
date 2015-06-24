App.IndexRoute = Ember.Route.extend({
 // model does not return array, but instead an object that contains an array
 // Remember that to filter you need to call posts instead
  model: function() {
      return Ember.Object.create({
         posts: this.store.findAll('post')
      });
  }
// For future use when implementing search by Topic...  
//    model: function() {
//    return [{color:'red'}, {color:'yellow'}, {color:'blue'}];
//  }
});
