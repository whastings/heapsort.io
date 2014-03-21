"use strict";

var Categories = require('../collections/categories'),
    Resource = require('./resource'),
    Resources = require('../collections/resources');

var Category = module.exports = Backbone.Model.extend({
  urlRoot: '/api/categories',

  children: function() {
    return this._children || (this._children = new Categories());
  },

  empty: function() {
    this.children().reset([]);
    this.resources().reset([]);
  },

  parse: function(data) {
    this.empty();
    var resources = this.resources();
    resources.total = data.resources_count;
    resources.categoryId = this.id;
    addChildren.call(this, data);
    addResources.call(this, data);

    if (!data.parent_id) {
      data.parent_id = 0;
    }

    return data;
  },

  resources: function() {
    return this._resources ||
      (this._resources = new Resources([], {categoryId: this.id}));
  }
});

var addChildren = function(data) {
  var children = this.children();
  if (Array.isArray(data.children)) {
    data.children.forEach(function(child) {
      children.add(new Category(child));
    });
    delete data.children;
  }
};

var addResources = function(data) {
  var resources = this.resources();
  if (Array.isArray(data.resources)) {
    data.resources.forEach(function(resource) {
      resources.add(new Resource(resource));
    });
    delete data.resources;
  }
};
