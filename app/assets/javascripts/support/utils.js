"use strict";

Handlebars.registerHelper('get', function(attribute) {
  return new Handlebars.SafeString(this.get(attribute));
});

exports.fixHeight = function($element) {
  var bodyHeight = $('body').height();
  $element.css('min-height', bodyHeight);
};

exports.isSignedIn = function() {
  return document.cookie.indexOf('signed_in=true') !== -1;
};
