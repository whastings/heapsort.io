var Resource = require('../models/resource');

var ResourcesList = module.exports = Backbone.Collection.extend({

  url: '/api/resources',
  model: Resource

});
