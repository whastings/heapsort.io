"use strict";

var CompoundView = require('../../support/compound_view'),
    Resource = require('../../models/resource');

var ResourcePage = module.exports = CompoundView.extend({
  className: 'row',
  modelEvents: {
    'sync': 'render'
  },
  template: HandlebarsTemplates['pages/resource_page'],

  initialize: function(options) {
    this.model = new Resource({id: options.resourceId});
    this.model.fetch();
  },

  render: function() {
    CompoundView.prototype.render.apply(this);

    return this;
  }
});
