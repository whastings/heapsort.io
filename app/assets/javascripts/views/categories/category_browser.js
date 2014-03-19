"use strict";

var CategoriesList = require('./categories_list'),
    CompoundView = require('../../support/compound_view');

var CategoryBrowser = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['categories/category_browser'],

  initialize: function() {
    this.addSubview(
      '#js-categories-list',
      new CategoriesList({collection: this.collection})
    );
  }
});
