import Ember from 'ember';

const { inject: { service }, RSVP } = Ember;
export default Ember.Service.extend ({
  session: service('session'),
  store: service(),
  serverValidationComplete: false,
  server422: false,
  
  // Create a Promise to handle a server request that validates the current LocalStorage
  // If valid, then set SessionAccount User.
  loadCurrentUser() {
    if (!Ember.isEmpty(this.get('session.data.authenticated.userId'))) {
      this.serverValidation().then(() => {
        return new RSVP.Promise((resolve, reject) => {
          const userId = this.get('session.data.authenticated.userId');
            // Get User to Session-Account Block
            if(this.get('serverValidationComplete') === true) {
              return this.get('store').find('user', userId).then((user) => {
                this.set('user', user);
                resolve();
              }).catch((reason) => {
                console.log(reason.errors);
                var possible404 = reason.errors.filterBy('status','404');
                var possible500 = reason.errors.filterBy('status','500');
                // User has tampered the Local Storage.
                if(possible404.length !== 0) {
                  alert('404 | Invalid Account Credentials.');
                  this.get('session').invalidate();
                }
                else if(possible500.length !== 0) {
                  alert('500 | Server Error');
                  this.get('session').invalidate();
                }
                reject();
              });
            }
            else if(this.get('server422') === true) {
              console.log('422 | Waiting for login reload...');
              resolve();
            }
            else{
              alert('Session for Server Validation failed! Logging out!');
              this.get('session').invalidate();
              resolve();
            }
        });
      });
    } else {
      // Session is empty...
    }
  },
  serverValidation() {
    return new RSVP.Promise((resolve) => {
      var tokenAuthentication = this.get('store').createRecord('token', {
        id: this.get('session.data.authenticated.userId'),
        email: this.get('session.data.authenticated.email'),
        authenticity_token: this.get('session.data.authenticated.token')
      });
      tokenAuthentication.save().then(() => {
        this.set('serverValidationComplete',true);
        console.log('Server Validation complete with 200');
        resolve();
      }).catch((reason) => {
        this.set('serverValidationComplete',false);
        var possible422 = reason.errors.filterBy('detail','The adapter rejected the commit because it was invalid');
        // Force Page reload to sync sessions if Server replies with 422
        if(possible422.length !== 0) {
          console.log('422 | Sessions not fully synced due to login.');
          this.set('server422',true);
        }
        console.log(reason);
        resolve();
      });
    });
  }
});
