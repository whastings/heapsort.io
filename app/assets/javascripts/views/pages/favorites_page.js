"use strict";

var CompoundView = require('../../support/compound_view'),
    ControlBar = require('../control_bars/control_bar'),
    Favorites = require('../../collections/favorites'),
    ResourcesList = require('../resources/resources_list');

var FavoritesPage = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['pages/favorites_page'],

  initialize: function() {
    var self = this;
    this.addSubview('#js-control-bar', new ControlBar());
    this.collection = new Favorites();
    this.collection.fetch({success: function() {
      self.collection.forEach(function(resource) {
        self.listenTo(resource, 'unfavorited', self.removeFavorite);
      });
    }});
    this.resourcesList = new ResourcesList({collection: this.collection});
    this.addSubview('#js-favorites-list', this.resourcesList);
  },

  removeFavorite: function(resource) {
    this.stopListening(resource);
    this.collection.remove(resource);
  }
});
