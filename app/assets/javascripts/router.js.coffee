# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->

   # Resources
   @resource 'posts'
   @resource 'post', path: '/posts/:id'
   
   @resource 'genres'
   @resource 'genre', path: '/genres/:id'
   
   @resource 'factTypes'
   
   @resource 'factPostDates'
   
   # Footer Routes
   @route 'about'
   @route 'legal_info'
   @route 'privacy_info'
   @route 'support'
   @route 'about'

