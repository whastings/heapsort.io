"use strict";

var CompoundView = require('../../support/compound_view'),
    ControlBar = require('../control_bars/control_bar'),
    Favorites = require('../../collections/favorites'),
    ResourcesList = require('../resources/resources_list');

var FavoritesPage = module.exports = CompoundView.extend({
  className: 'row',
  template: HandlebarsTemplates['pages/favorites_page'],

  initialize: function() {
    this.addSubview('#js-control-bar', new ControlBar());
    var favorites = new Favorites();
    favorites.fetch();
    this.resourcesList = new ResourcesList({collection: favorites});
    this.addSubview('#js-favorites-list', this.resourcesList);
  }
});
