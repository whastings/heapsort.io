"use strict";

var HomePage = require('./views/pages/home_page'),
    ResourcePage = require('./views/pages/resource_page'),
    utils = require('./support/utils');

var AppRouter = module.exports = Backbone.Router.extend({
  routes: {
    '': 'home',
    'categories/:id': 'showCategory',
    'resources/:id': 'showResource'
  },

  home: function() {
    if (!this.homeView) {
      this.homeView = new HomePage({categoryId: 0});
    }
    swapView.call(this, this.homeView);
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  showCategory: function(id) {
    if (!this.homeView) {
      this.homeView = new HomePage({categoryId: id});
      swapView.call(this, this.homeView);
    } else {
      this.homeView.changeCategory(id);
    }
  },

  showResource: function(id) {
    swapView.call(this, new ResourcePage({resourceId: id}));
  }
});

var swapView = function(view) {
  if (view !== this.homeView) {
    this.currentView && this.currentView.remove(); // jshint ignore:line
  }
  this.currentView = view;
  this.$rootEl.html(view.render().$el);
  utils.fixHeight($('.content-main'));
};
