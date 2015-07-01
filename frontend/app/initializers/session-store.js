export function initialize(container, application) {
  application.inject('session:custom', '_store', 'store:main');

  // "store:main" is highly dynamic depepeding on ember-data version
  // in 1.0.0-beta.19 (June 5, 2015) => "store:application"
  // in 1.13 (June 16, 2015) => "service:store"
}

export default {
  name: 'session-store',
  after: 'ember-data',
  initialize: initialize
};
