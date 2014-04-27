"use strict";

var AppRouter = require('./app_router'),
    notice = require('./support/notice');

var App = function() {

};

_.extend(App.prototype, {
  attachLinkHandler: function() {
    $(document).on('click', "a[href^='/']", this.navigate);
  },

  initialize: function() {
    var $rootEl = $('#js-content');
    this.router = new AppRouter({
      $rootEl: $rootEl
    });
    Backbone.history.start({pushState: true});
    this.attachLinkHandler();
    this.showNotice();
  },

  navigate: function(event) {
    // Properly route link clicks through Backbone.
    // See more at:
    //   http://artsy.github.io/blog/2012/06/25/replacing-hashbang-routes-with-pushstate/
    var href = $(event.currentTarget).attr('href');
    if (!event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey) {
      event.preventDefault();
      var url = href.replace(/^\//,'').replace(/^#\//,'');
      Backbone.history.navigate(url, {trigger: true});
    }
  },

  showNotice: function() {
    var $notice = $('#js-page-notice');
    if (!$notice.length) {
      return;
    }
    notice.display($notice.html());
  }
});

$(function() {
  var app = new App();
  app.initialize();
});
