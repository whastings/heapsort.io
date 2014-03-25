"use strict";

var ResourceTypes = require('../../collections/resource_types');

var BrowserControlBar = module.exports = Backbone.Marionette.ItemView.extend({
  events: {
    'click .js-type-filter': 'toggleTypeFilter'
  },
  template: HandlebarsTemplates['control_bars/browser_control_bar'],

  initialize: function() {
    this.resourceTypes = new ResourceTypes();
    this.resourceTypes.fetch({success: this.render.bind(this)});
  },

  templateHelpers: function() {
    return {
      types: this.resourceTypes.toJSON()
    };
  },

  toggleTypeFilter: function(event) {
    var $checkbox = $(event.target),
        typeId = parseInt($checkbox.val());
    if ($checkbox.is(':checked')) {
      this.collection.addTypeFilter(typeId);
    } else {
      this.collection.removeTypeFilter(typeId);
    }
  }
});

