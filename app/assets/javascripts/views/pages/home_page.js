"use strict";

var Category = require('../../models/category'),
    CategoryBrowser = require('../categories/category_browser'),
    CompoundView = require('../../support/compound_view'),
    IndexControlBar = require('../control_bars/index_control_bar');

var HomePage = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['pages/home_page'],

  changeCategory: function(id) {
    var self = this;
    this.rootCategory.set('friendly_id', id);
    var loadFinished = false;
    window.setTimeout(function() {
      if (!loadFinished) {
        addLoadingDiv.call(self);
      }
    }, 500);
    this.rootCategory.fetchByFriendlyId({success: function() {
      loadFinished = true;
      self.rootCategory.trigger('categoryChanged');
      removeLoadingDiv.call(self);
    }});
  },

  hide: function() {
    this.$el.hide();
  },

  initialize: function(options) {
    var rootCategory = this.rootCategory = new Category({friendly_id: options.categoryId});
    rootCategory.fetchByFriendlyId();
    this.addSubview(
      '#js-index-control-bar',
      new IndexControlBar()
    );
    this.addSubview(
      '#js-category-browser',
      new CategoryBrowser({
        collection: rootCategory.children(),
        model: rootCategory
      })
    );
  },

  onRender: function() {
    this.rendered = true;
  },

  show: function() {
    this.$el.show();
  }
});

var addLoadingDiv = function() {
  var $container = this.$('#js-category-browser');
  this.loadingDiv = this.loadingDiv || $('<div>');
  this.loadingDiv.addClass('loading-graphic');
  var offset = $container.offset();
  this.loadingDiv.css({
    height: $container.height()
  });
  this.loadingDiv.appendTo($container);
  this.loadingDiv.offsetWidth; // Force a reflow.
  // TODO: Figure out why the background div isn't fading in.
  this.loadingDiv.addClass('show');
  this.spinner = this.spinner || getSpinner();
  this.spinner.spin();
  $container.append(this.spinner.el);
};

var removeLoadingDiv = function() {
  this.loadingDiv && this.loadingDiv.remove();
  this.spinner && this.spinner.stop();
};

var getSpinner = function() {
  var spinnerOptions = {
    color: '#b0e0f8',
    length: 40,
    radius: 96,
    width: 20
  };
  return new Spinner(spinnerOptions);
};

