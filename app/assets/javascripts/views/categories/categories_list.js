"use strict";

var CategoriesList = module.exports = Backbone.Marionette.ItemView.extend({
  collectionEvents: {
    'add': 'render'
  },
  tagName: 'ul',
  template: HandlebarsTemplates['categories/categories_list'],
  templateHelpers: {},

  initialize: function(options) {
    this.templateHelpers.parentCategory = options.parentCategory.attributes;
  }
});
