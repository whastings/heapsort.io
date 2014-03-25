"use strict";

var FavoriteControls = require('../../mixins/favorite_controls');

var ResourceTeaser = module.exports = Backbone.Marionette.ItemView.extend({
  modelEvents: {
    'favorited': 'render',
    'unfavorited': 'render'
  },
  template: HandlebarsTemplates['resources/teaser']
});

$.extend(true, ResourceTeaser.prototype, FavoriteControls);
