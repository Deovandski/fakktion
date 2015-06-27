import DS from "ember-data";

export default DS.Model.extend({
  genreName: DS.attr('string'),
  posts: DS.hasMany('post', { async: true })
});
