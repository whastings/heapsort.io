"use strict";

var HomePage = require('./views/pages/home_page'),
    FavoritesPage = require('./views/pages/favorites_page'),
    FeedPage = require('./views/pages/feed_page'),
    ResourceForm = require('./views/pages/resource_form'),
    ResourcePage = require('./views/pages/resource_page'),
    utils = require('./support/utils');

var AppRouter = module.exports = Backbone.Router.extend({
  routes: {
    '': 'home',
    'categories/*friendly_id': 'showCategory',
    'favorites': 'showFavorites',
    'feed': 'showFeed',
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
    } else {
      this.homeView.changeCategory(id);
    }
    swapView.call(this, this.homeView);
  },

  showFavorites: function() {
    if (!requireSignedIn()) {
      return;
    }
    swapView.call(this, new FavoritesPage());
  },

  showFeed: function() {
    if (!requireSignedIn()) {
      return;
    }
    swapView.call(this, new FeedPage());
  },

  showResource: function(id) {
    swapView.call(this, new ResourcePage({resourceId: id}));
  },

  showResourceForm: function() {
    if (!requireSignedIn()) {
      return;
    }
    swapView.call(this, new ResourceForm());
  }
});

var requireSignedIn = function() {
  if (!utils.isSignedIn()) {
    window.location = '/signin';
    return false;
  }
  return true;
};

var swapView = function(view) {
  this.currentView && this.currentView.remove(); // jshint ignore:line
  if (view !== this.homeView) {
    this.currentView = view;
    this.homeView && this.homeView.hide(); // jshint ignore:line
  } else if (this.homeView.rendered) {
    this.homeView.show();
    return;
  }
  view.on('render', function() {
    utils.fixHeight(view.$('.content-main'));
  });
  this.$rootEl.append(view.render().$el);
};
