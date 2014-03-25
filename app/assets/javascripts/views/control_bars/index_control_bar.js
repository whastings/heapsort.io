"use strict";

var CategorySubscription = require('../../models/category_subscription'),
    CompoundView = require('../../support/compound_view'),
    ControlBar = require('./control_bar'),
    Favorite = require('../../models/favorite');

var IndexControlBar = module.exports = CompoundView.extend({
  events: {
    'drop #js-category-drop': 'subscribeToCategory'
  },
  template: HandlebarsTemplates['control_bars/index_control_bar'],

  initialize: function() {
    this.addSubview(
      '#js-basic-control-bar',
      new ControlBar({hideBackLink: true})
    );
  },

  onRender: function() {
    this.$('.drop-region').droppable({tolerance: 'touch'});
  },

  subscribeToCategory: function(event, ui) {
    var categoryId = ui.draggable.data('id');
    var subscription = new CategorySubscription({category_id: categoryId});
    subscription.save();
  }
});
