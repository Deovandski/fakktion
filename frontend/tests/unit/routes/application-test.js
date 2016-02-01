import { moduleFor, test } from 'ember-qunit';

moduleFor('route:application', 'Unit | Route | Application ', {
  // Specify the other units that are required for this test.
  needs: ['service:session', 'router:main']
});

test('it exists', function(assert) {
  var route = this.subject();
  assert.ok(route);
});
