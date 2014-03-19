"use strict";

var Categories = require('../collections/categories'),
    Resource = require('./resource'),
    Resources = require('../collections/resources');

var Category = module.exports = Backbone.Model.extend({
  urlRoot: '/api/categories',

  children: function() {
    return this._children || (this._children = new Categories());
  },

  parse: function(data) {
    addChildren.call(this, data);
    addResources.call(this, data);

    if (!data.parent_id) {
      data.parent_id = 0;
    }

    return data;
  },

  resources: function() {
    return this._resources || (this._resources = new Resources());
  }
});

var addChildren = function(data) {
  var children = this.children();
  if (Array.isArray(data.children)) {
    data.children.forEach(function(child) {
      children.add(new Category(child));
    });
  }
};

var addResources = function(data) {
  var resources = this.resources();
  if (Array.isArray(data.resources)) {
    data.resources.forEach(function(resource) {
      resources.add(new Resource(resource));
    });
  }
};
