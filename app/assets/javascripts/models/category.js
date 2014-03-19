"use strict";

var Categories = require('../collections/categories');

var Category = module.exports = Backbone.Model.extend({
  urlRoot: '/api/categories',

  children: function() {
    return this._children || (this._children = new Categories());
  },

  parse: function(data) {
    var children = this.children();
    if (Array.isArray(data.children)) {
      data.children.forEach(function(child) {
        children.add(new Category(child));
      });
    }

    return data;
  }
});
