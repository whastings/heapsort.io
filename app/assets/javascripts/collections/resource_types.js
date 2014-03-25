"use strict";

var ResourceType = require('../models/resource_type');

var ResourceTypes = module.exports = Backbone.Collection.extend({
  model: ResourceType,
  url: '/api/resource_types'
});
