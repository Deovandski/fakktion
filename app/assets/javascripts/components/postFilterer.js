App.PostFiltererComponent = Ember.Component.extend({
    searchText: null,

    searchResults: function() {
        var model = this.get('model'),
            searchText = this.get('searchText'),
            filterByPath = this.get('filterByPath'),
            visualPath = this.get('visualPath');

        console.log(this.get('model')); // shows array

        if (searchText){
            console.log('searching for: ' + searchText); // shows up in console with searchText

          
          model = model.filter( function(item){
            console.log(item);
            return Em.get(item,filterByPath).indexOf(searchText) >= 0;
          });
        }

        return model.getEach(visualPath);
    }.property('searchText')
});
