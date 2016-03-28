import Ember from "ember";

/* This helper may receive undefined as some Handlebars
 * requests are being eagerly sent before the promise
 * is resolved. Instead of letting hell break loose, we simply send
 * the undefined back to the Ahole who called it...
 * But seriously, do not let the method be called 
 * on a undefined parameter!
*/

export default Ember.Helper.helper(function([value]) {
  var tempValue = null;
  if (value === undefined) {
    return value;
  }
  else {
    if(value < 1000){
      return value;
    }
    if(value >= 1000 && value < 1000000){
      tempValue = Math.floor(value * 0.001);
      return tempValue + "k";
    }
    else if(value >= 1000000 && value < 1000000000){
      tempValue = Math.floor(value * 0.000001);
      return tempValue + "kk";
    }
    else if(value >= 1000000 && value < 1000000000){
      tempValue = Math.floor(value * 0.000001);
      return tempValue + "kk";
    }
    else{
      return "1b+";
    }
  }
});
