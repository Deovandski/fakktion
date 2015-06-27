import Ember from 'ember';
import Resolver from 'ember/resolver';
import loadInitializers from 'ember/load-initializers';
import config from './config/environment';

var App;

Ember.MODEL_FACTORY_INJECTIONS = true;

App = Ember.Application.extend({
  modulePrefix: config.modulePrefix,
  podModulePrefix: config.podModulePrefix,
  Resolver: Resolver,
  LOG_TRANSITIONS_INTERNAL:  true,
  LOG_ACTIVE_GENERATION:     true,
  LOG_VIEW_LOOKUPS:          true
});

loadInitializers(App, config.modulePrefix);

export default App;
