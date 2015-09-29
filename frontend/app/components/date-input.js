// Date Input Component
import Ember from 'ember';
import moment from 'moment';

export default Ember.TextField.extend ({
	inputDate: function(key, date) {
		this.set('placeholder', moment(date).format('MM/DD/YYYY'));
	}.property('placeholder')
});