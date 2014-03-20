"use strict";

var CategoriesList = module.exports = Backbone.Marionette.ItemView.extend({
  tagName: 'ul',
  template: HandlebarsTemplates['categories/categories_list'],
  templateHelpers: {},

  initialize: function(options) {
    this.templateHelpers.parentCategory = options.parentCategory.attributes;
  }
});
