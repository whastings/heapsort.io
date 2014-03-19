"use strict";

var HomePage = require('./views/pages/home_page');

var AppRouter = module.exports = Backbone.Router.extend({
  routes: {
    '': 'home',
    'categories/:id': 'showCategory'
  },

  home: function() {
    swapView.call(this, new HomePage({categoryId: 0}));
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  },

  showCategory: function(id) {
    swapView.call(this, new HomePage({categoryId: id}));
  }
});

var swapView = function(view) {
  this.currentView && this.currentView.remove(); // jshint ignore:line
  this.currentView = view;
  this.$rootEl.html(view.render().$el);
};
