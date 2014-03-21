"use strict";

var Categories = module.exports = Backbone.Collection.extend({
  comparator: 'name',
  url: '/api/categories'
});
