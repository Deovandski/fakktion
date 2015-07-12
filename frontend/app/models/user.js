import DS from "ember-data";

export default DS.Model.extend({
  fullName: DS.attr ('string'),
  displayName: DS.attr ('string'),
  password: DS.attr ('string'),
  email: DS.attr ('string'),
  dateOfBirth: DS.attr ('date'),
  gender: DS.attr ('number'),
  facebookId: DS.attr ('number'),
  twitterUrl: DS.attr ('string'),
  personalMessage: DS.attr ('string'),
  webpageUrl: DS.attr ('string'),
  isBanned: DS.attr ('boolean'),
  isBannedDate: DS.attr ('date'),
  numberOfPosts: DS.attr ('number'),
  numberOfComments: DS.attr ('number'),
  legalTermsRead: DS.attr ('boolean'),
  privacyTermsRead: DS.attr ('boolean'),
  isAdmin: DS.attr ('boolean'),
  isSuperUser: DS.attr ('boolean'),
  signInCount: DS.attr ('boolean'),
});
