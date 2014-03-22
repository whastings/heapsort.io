"use strict";

var CompoundView = require('../../support/compound_view'),
    ControlBar = require('../control_bars/control_bar'),
    Resource = require('../../models/resource');

var ResourceForm = module.exports = CompoundView.extend({
  bindings: {
    '#js-resource-form-title': 'title',
    '#js-resource-form-url': 'url',
    '#js-resource-form-desc': 'description'
  },
  className: 'row',
  events: {
    'submit form': 'submit'
  },
  template: HandlebarsTemplates['pages/resource_form'],

  initialize: function(options) {
    this.model = new Resource();
    this.addSubview('#js-control-bar', new ControlBar({hideShareLink: true}));
  },

  render: function() {
    CompoundView.prototype.render.apply(this);
    this.stickit();
    return this;
  },

  submit: function(event) {
    event.preventDefault();
    this.model.save({}, {success: handleSuccess.bind(this)});
  }
});

var handleSuccess = function(model) {
  Backbone.history.navigate('resources/' + model.id, {trigger: true});
};
