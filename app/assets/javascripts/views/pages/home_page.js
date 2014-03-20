"use strict";

var Category = require('../../models/category'),
    CategoryBrowser = require('../categories/category_browser'),
    CompoundView = require('../../support/compound_view');

var HomePage = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['pages/home_page'],

  changeCategory: function(id) {
    var self = this;
    this.rootCategory.set('id', id);
    this.rootCategory.empty();
    this.rootCategory.fetch({success: function() {
      self.rootCategory.trigger('categoryChanged');
    }});
  },

  initialize: function(options) {
    var rootCategory = this.rootCategory = new Category({id: options.categoryId});
    rootCategory.fetch();
    this.addSubview(
      '#js-category-browser',
      new CategoryBrowser({
        collection: rootCategory.children(),
        model: rootCategory
      })
    );
  }
});
