"use strict";

var ControlBar = require('./control_bar');

var IndexControlBar = module.exports = ControlBar.extend({
  initialize: function() {
    ControlBar.prototype.initialize.call(this, {hideBackLink: true});
  }
});
