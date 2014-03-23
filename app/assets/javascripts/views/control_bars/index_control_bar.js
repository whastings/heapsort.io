"use strict";

var CompoundView = require('../../support/compound_view'),
    ControlBar = require('./control_bar'),
    Favorite = require('../../models/favorite');

var IndexControlBar = module.exports = CompoundView.extend({
  events: {
    'drop #js-favorite-drop': 'addFavorite'
  },
  template: HandlebarsTemplates['control_bars/index_control_bar'],

  addFavorite: function(event, ui) {
    var resourceId = ui.draggable.children().first().data('id');
    var favorite = new Favorite({resource_id: resourceId});
    favorite.save();
  },

  initialize: function() {
    this.addSubview(
      '#js-basic-control-bar',
      new ControlBar({hideBackLink: true})
    );
  },

  onRender: function() {
    this.$('.drop-region').droppable({tolerance: 'touch'});
  }
});
