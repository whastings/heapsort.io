"use strict";

var Resource = require('../models/resource');

var Resources = module.exports = Backbone.Collection.extend({

  url: '/api/resources',
  model: Resource

});
