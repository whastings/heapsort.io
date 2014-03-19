"use strict";

var HomePage = require('./views/pages/home_page');

var AppRouter = module.exports = Backbone.Router.extend({
  routes: {
    '': 'home'
  },

  home: function() {
    swapView.call(this, new HomePage());
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
  }
});

var swapView = function(view) {
  this.currentView && this.currentView.remove(); // jshint ignore:line
  this.currentView = view;
  this.$rootEl.html(view.render().$el);
};
