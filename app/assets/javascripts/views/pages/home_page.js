"use strict";

var Category = require('../../models/category'),
    CategoryBrowser = require('../categories/category_browser'),
    CompoundView = require('../../support/compound_view');

var HomePage = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['pages/home_page'],

  initialize: function() {
    var rootCategory = new Category({id: 0});
    rootCategory.fetch();
    this.addSubview(
      '#js-category-browser',
      new CategoryBrowser({collection: rootCategory.children()})
    );
  }
});
