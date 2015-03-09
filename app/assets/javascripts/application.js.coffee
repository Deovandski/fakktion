#= require jquery
#= require jquery_ujs
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require app

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create(
  LOG_TRANSITIONS_INTERNAL: true 
  LOG_VIEW_LOOKUPS: true
  LOG_ACTIVE_GENERATION: true
  )

