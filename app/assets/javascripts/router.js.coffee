
# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->

   # Resources
   @route 'posts'
   @route 'post', path: '/posts/:id'
   
   @route 'genres'
   @route 'genre', path: '/genres/:id'
   
   @route 'categories'
   @route 'categorie', path: '/categories/:id'
   
   @route 'postingDates'
   @route 'postingDate', path: '/postingDates/:id'
   
   @route 'factTypes'
   @route 'factType', path: '/factTypes/:id'
   
   # Footer Routes
   @route 'about'
   @route 'legal_info'
   @route 'privacy_info'
   @route 'support'
   @route 'about'

