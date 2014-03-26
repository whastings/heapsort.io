"use strict";

/**
 * A constructor-less prototypal inheritance utility.
 *
 * Inspiration: Kyle Simpson's 'De"construct"ion':
 *   http://davidwalsh.name/javascript-objects-deconstruction
 *
 * Credits:
 *   - Mark Shlick for the callSuper idea.
 */
var newProto = module.exports = (function() {
  var getProperties = function(object) {
    var properties = {};
    for (var property in object) {
      if (!object.hasOwnProperty(property)) {
        continue;
      }
      properties[property] = { value: object[property] };
    }
    return properties;
  };

  return function(proto, superProto) {
    if (superProto) {
      proto = Object.create(superProto, getProperties(proto));
      proto.callSuper = function(methodName) {
        if (typeof superProto[methodName] !== 'function') {
          throw new Error('Method ' + methodName + ' is not defined.');
        }
        var args = Array.prototype.slice.call(arguments, 1);
        return superProto[methodName].apply(this, args);
      };
    }
    proto.create = function() {
      var newObject = Object.create(proto);
      if (typeof proto.initialize === 'function') {
        proto.initialize.apply(newObject, arguments);
      }
      return newObject;
    };
    return proto;
  };

})();
