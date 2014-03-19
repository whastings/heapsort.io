"use strict";

var AppRouter = require('./app_router'),
    utils = require('./support/utils');

var App = function() {

};

_.extend(App.prototype, {
  initialize: function() {
    var $rootEl = $('#js-content');
    this.router = new AppRouter({
      $rootEl: $rootEl
    });
    Backbone.history.start();
  }
});

$(function() {
  var app = new App();
  app.initialize();
});
