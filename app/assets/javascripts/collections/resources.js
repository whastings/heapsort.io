"use strict";

var Resource = require('../models/resource');

var Resources = module.exports = Backbone.Collection.extend({

  url: function() {
    return '/api/categories/' + this.category.id +
      '/resources?page=' + this.page;
  },
  model: Resource,

  fetchNextPage: function() {
    this.page += 1;
    this.fetch({remove: false});
  },

  initialize: function(models, options) {
    options = options || {};
    this.category = options.category;
    this.page = 1;
  },

  parse: function(data) {
    if (data.total) {
      this.total = data.total;
    }
    return data.resources;
  },

  reset: function() {
    this.page = 1;
    var args = Array.prototype.slice.call(arguments);
    Backbone.Collection.prototype.reset.apply(this, args);
  }

});
