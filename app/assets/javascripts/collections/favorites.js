"use strict";

var Resources = require('./resources');

var Favorites = module.exports = Resources.extend({
  url: '/api/favorites'
});
