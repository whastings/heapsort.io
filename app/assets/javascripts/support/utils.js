"use strict";

Handlebars.registerHelper('get', function(attribute) {
  return new Handlebars.SafeString(this.get(attribute));
});

exports.fixHeight = function($element) {
  var bodyHeight = $('body').height();
  $element.css('min-height', bodyHeight);
};
