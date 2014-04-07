"use strict";

var breakpoints = {
  'screen-xs': 0,
  'screen-sm': 768,
  'screen-md': 992,
  'screen-lg': 1480,
};

exports.maxWidth = _.memoize(function(breakpoint) {
  var query = '(max-width: ' + breakpoints[breakpoint] + 'px)';
  return window.matchMedia(query).matches;
});

exports.minWidth = _.memoize(function(breakpoint) {
  var query = '(min-width: ' + breakpoints[breakpoint] + 'px)';
  return window.matchMedia(query).matches;
});
