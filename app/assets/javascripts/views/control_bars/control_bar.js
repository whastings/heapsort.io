"use strict";

var ControlBar = module.exports = Backbone.Marionette.ItemView.extend({
  className: 'control-bar',
  template: HandlebarsTemplates['control_bars/control_bar'],
  templateHelpers: {
    showShareLink: true,
    showBackLink: true
  },

  initialize: function(options) {
    options = options || {};
    this.templateHelpers = _.clone(ControlBar.prototype.templateHelpers);
    if (options.hideShareLink) {
      this.templateHelpers.showShareLink = false;
    }
    if (options.hideBackLink) {
      this.templateHelpers.showBackLink = false;
    }
  }
});
