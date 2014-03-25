"use strict";

var BrowserControlBar = require('../control_bars/browser_control_bar'),
    CategoriesList = require('./categories_list'),
    CompoundView = require('../../support/compound_view'),
    ResourcesList = require('../resources/resources_list');

var CategoryBrowser = module.exports = CompoundView.extend({
  className: 'row',
  modelEvents: {
    'categoryChanged': 'changeCategory'
  },
  template: HandlebarsTemplates['categories/category_browser'],
  ui: {
    resourcesContainer: '#js-resources-list'
  },
  welcomeTemplate: HandlebarsTemplates['pages/welcome'],

  changeCategory: function() {
    this.categoriesList.transition(this.model);
    toggleWelcomeMessage.call(this);
  },

  initialize: function() {
    this.categoriesList = new CategoriesList({
      collection: this.collection, parentCategory: this.model
    });
    this.addSubview(
      '#js-categories-list',
      this.categoriesList
    );
    this.resourcesList = new ResourcesList({collection: this.model.resources()});
    this.addSubview('#js-resources-list', this.resourcesList);
    this.addSubview(
      '#js-browser-controls',
      new BrowserControlBar({collection: this.model.resources()})
    );
    this.listenToOnce(this.model, 'sync', this.render);
  },

  render: function() {
    CompoundView.prototype.render.call(this);
    toggleWelcomeMessage.call(this);
    return this;
  }
});

var toggleWelcomeMessage = function() {
  if (this.model.id === null || parseInt(this.model.id) === 0) {
    $(this.ui.resourcesContainer).prepend(this.welcomeTemplate());
  } else {
    this.$('.welcome-message').remove();
  }
};
