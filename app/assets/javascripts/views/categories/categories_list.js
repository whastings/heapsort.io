"use strict";

var CategoriesList = module.exports = Backbone.Marionette.ItemView.extend({
  collectionEvents: {
    'add': 'render'
  },
  template: HandlebarsTemplates['categories/categories_list']
});
