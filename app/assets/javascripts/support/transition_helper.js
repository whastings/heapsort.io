"use strict";

module.exports = {
  addTransform: function($element, transformFn) {
    var transformArgs = Array.prototype.slice.call(arguments, 2).join(', '),
        transformValue = transformFn + '(' + transformArgs + ')';
    $element.css({
      '-webkit-transform': transformValue,
      '-moz-transform': transformValue,
      '-ms-transform': transformValue,
      '-o-transform': transformValue,
      'transform': transformValue
    });
  },
  onTransitionEnd: function($element, duration, callback) {
    var called = false;
    $element.one(
      'webkitTransitionEnd otransitionend msTransitionEnd transitionend',
      function() {
        called = true;
        callback();
      }
    );
    window.setTimeout(function() {
      if (!called) {
        $element.trigger('transitionend');
      }
    }, duration);
  }
};
