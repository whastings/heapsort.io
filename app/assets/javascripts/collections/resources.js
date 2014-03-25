"use strict";

var Resource = require('../models/resource');

var Resources = module.exports = Backbone.Collection.extend({

  comparator: function(resource1, resource2) {
    var ratingDiff = resource1.get('rating') - resource2.get('rating');
    if (ratingDiff !== 0) {
      return ratingDiff;
    }
    var title1 = resource1.get('title'),
        title2 = resource2.get('title');
    return title1 > title2 ? 1 : -1;
  },
  url: function() {
    return '/api/categories/' + this.categoryId +
      '/resources?page=' + this.page;
  },
  model: Resource,

  addTypeFilter: function(typeId) {
    var originalList = this.originalList();
    this.filteredTypes.push(typeId);
    // @TODO If page greater than 1 and filters applied, reset to page 1.
    if (this.filteredTypes.length === 1) {
      this.reset();
    }
    this.add(originalList.filter(filterByTypeId.bind(null, typeId)));
    this.sort();
  },

  fetchNextPage: function() {
    this.page += 1;
    this.fetch({remove: false});
  },

  initialize: function(models, options) {
    options = options || {};
    this.categoryId = options.categoryId;
    this.page = 1;
    this.filteredTypes = [];
  },

  originalList: function() {
    return this._originalList || (this._originalList = this.models.slice());
  },

  removeTypeFilter: function(typeId) {
    this.filteredTypes.splice(this.filteredTypes.indexOf(typeId), 1);
    // @TODO If page greater than 1 and filters applied, reset to page 1.
    if (!this.filteredTypes.length) {
      this.reset(this.originalList());
      return;
    }
    this.remove(this.filter(filterByTypeId.bind(null, typeId)));
    this.sort();
  }

});

var filterByTypeId = function(typeId, resource) {
  return resource.get('resource_type_id') === typeId;
};

