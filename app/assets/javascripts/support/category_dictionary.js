"use strict";

var newProto = require('./new_proto');

var CategoryDictionary = module.exports = newProto({
  dictionary: function() {
    return this._dictionary || (this._dictionary = {});
  },

  getChildren: function(parentId) {
    return this.dictionary()[parentId];
  },

  initialize: function(categories) {
    this.collection = categories;
    this.listenTo(this.collection, 'sync', this.resetDictionary);
  },

  resetDictionary: function() {
    var dictionary = this._dictionary = {};
    this.collection.forEach(function(category) {
      var parentId = category.get('parent_id');
      parentId = parentId || 0;
      if (dictionary[parentId] === undefined) {
        dictionary[parentId] = [];
      }
      dictionary[parentId].push(category);
    });
    this.trigger('reset');
  }
});

_.extend(CategoryDictionary, Backbone.Events);
