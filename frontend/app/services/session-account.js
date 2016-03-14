import Ember from 'ember';

const { inject: { service }, RSVP } = Ember;
// authentication_token
export default Ember.Service.extend ({
	session: service('session'),
	store: service(),
	
	loadCurrentUser() {
		return new RSVP.Promise((resolve, reject) => {
			const userId = this.get('session.data.authenticated.userId');
			const token = this.get('session.data.authenticated.token');
			const email = this.get('session.data.authenticated.email');
			if (!Ember.isEmpty(userId)) {
				return this.get('store').find('user', userId).then((user) => {
					this.set('user', user);
					if(token === this.get('user.authentication_token')){
						if(email === this.get('user.email')){
							resolve();
						}
						else{
							alert('LOCAL STORAGE HAS BEEN TAMPERED ON VALIDATION #2! LOGGING OUT');
							this.get('session').invalidate();
							resolve();
						}
					}
					else{
						alert('LOCAL STORAGE HAS BEEN TAMPERED ON VALIDATION #1! LOGGING OUT');
						this.get('session').invalidate();
						resolve();
					}
				}).catch((reason) => {
					var possible404 = reason.errors.filterBy('status','404');
					if(possible404 !== undefined) {
						this.get('session').invalidate();
					}
					reject;
				});
			} else {
				resolve();
			}
		});
	}
});
