"use strict";

var HomePage = require('./views/pages/home_page'),
    ResourceForm = require('./views/pages/resource_form'),
    ResourcePage = require('./views/pages/resource_page'),
    utils = require('./support/utils');

var AppRouter = module.exports = Backbone.Router.extend({
  routes: {
    '': 'home',
    'categories/:id': 'showCategory',
    'resources/:id': 'showResource',
    'share-resource': 'showResourceForm'
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
  },

  showResourceForm: function() {
    swapView.call(this, new ResourceForm());
  }
});

var swapView = function(view) {
  this.currentView && this.currentView.remove(); // jshint ignore:line
  if (view !== this.homeView) {
    this.currentView = view;
    this.homeView && this.homeView.hide(); // jshint ignore:line
  } else if (this.homeView.rendered) {
    this.homeView.show();
    return;
  }
  this.$rootEl.append(view.render().$el);
  utils.fixHeight($('.content-main'));
};
