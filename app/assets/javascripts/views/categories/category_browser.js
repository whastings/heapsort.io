"use strict";

var CategoriesList = require('./categories_list'),
    CompoundView = require('../../support/compound_view'),
    ResourcesList = require('../resources/resources_list');

var CategoryBrowser = module.exports = CompoundView.extend({
  className: 'row',
  modelEvents: {
    'change:parent_id': 'render'
  },
  template: HandlebarsTemplates['categories/category_browser'],
  ui: {
    resourcesContainer: '#js-resources-list'
  },
  welcomeTemplate: HandlebarsTemplates['pages/welcome'],

  initialize: function() {
    this.addSubview(
      '#js-categories-list',
      new CategoriesList({
        collection: this.collection, parentCategory: this.model
      })
    );
    var resourcesList = new ResourcesList({collection: this.model.resources()});
    this.addSubview('#js-resources-list', resourcesList);
  },

  render: function() {
    CompoundView.prototype.render.call(this);
    if (this.model.id === 0 || this.model.id === null) {
      $(this.ui.resourcesContainer).prepend(this.welcomeTemplate());
    }
    return this;
  }
});
