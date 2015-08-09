import Ember from "ember";
import moment from 'moment';

export default Ember.Controller.extend
({
	ageDate: function()
	{
		return "TEST"; //
	},
	updatedDate: function()
	{
		return "TEST"; //
		//return moment(this.get("model.updated_at"));
	},
	createdDate: function()
	{
		return "TEST"; // 
		//currentDate = moment();
		//tempDate3= moment(this.get("model.date_of_birth"));
		//return tempDate3.diff(currentDate);
	},
	/*
	<label>Profile Updated on: {{profileUpdatedOn}}</label>
	<label>Age: {{currentAge}}</label>
	*/
});
