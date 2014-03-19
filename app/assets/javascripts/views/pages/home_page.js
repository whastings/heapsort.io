"use strict";

var Category = require('../../models/category'),
    CategoryBrowser = require('../categories/category_browser'),
    CompoundView = require('../../support/compound_view');

var HomePage = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['pages/home_page'],

  initialize: function(options) {
    var rootCategory = new Category({id: options.categoryId});
    rootCategory.fetch();
    this.addSubview(
      '#js-category-browser',
      new CategoryBrowser({collection: rootCategory.children()})
    );
  }
});
