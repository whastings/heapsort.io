"use strict";

var Resource = require('../../models/resource');

var ResourceForm = module.exports = Backbone.Marionette.ItemView.extend({
  bindings: {
    '#js-resource-form-title': 'title',
    '#js-resource-form-url': 'url',
    '#js-resource-form-desc': 'description'
  },
  events: {
    'submit form': 'submit'
  },
  template: HandlebarsTemplates['pages/resource_form'],

  initialize: function(options) {
    this.model = new Resource();
  },

  render: function() {
    Backbone.Marionette.ItemView.prototype.render.apply(this);
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
