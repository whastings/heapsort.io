"use strict";

var Resource = require('../models/resource');

var Resources = module.exports = Backbone.Collection.extend({

  url: function() {
    return '/api/categories/' + this.categoryId +
      '/resources?page=' + this.page;
  },
  model: Resource,

  fetchNextPage: function() {
    this.page += 1;
    this.fetch({remove: false});
  },

  initialize: function(models, options) {
    options = options || {};
    this.categoryId = options.categoryId;
    this.page = 1;
  }

});
