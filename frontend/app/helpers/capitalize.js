import Ember from "ember";

/* This helper may receive undefined as some Handlebars
 * requests are being eagerly sent before the promise
 * is resolved. Instead of letting hell break loose, we simply send
 * the undefined back to the Ahole who called it...
 * But seriously, do not let the method be called
 * on a undefined parameter!
 */
export default Ember.Helper.helper(function([value]) {
  if (value === undefined) {
    return value;
  } else {
    return value.capitalize();
  }
});
