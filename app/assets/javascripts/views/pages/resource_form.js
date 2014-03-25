"use strict";

var CompoundView = require('../../support/compound_view'),
    ControlBar = require('../control_bars/control_bar'),
    Resource = require('../../models/resource'),
    ResourceTypes = require('../../collections/resource_types');

var ResourceForm = module.exports = CompoundView.extend({
  bindings: {
    '#js-resource-form-title': 'title',
    '#js-resource-form-url': 'url',
    '#js-resource-form-desc': 'description',
    'select#js-resource-form-type': {
      observe: 'resource_type_id',
      selectOptions: {
        collection: 'this.resourceTypes',
        labelPath: 'name',
        valuePath: 'id'
      }
    }
  },
  className: 'row',
  events: {
    'submit form': 'submit'
  },
  template: HandlebarsTemplates['pages/resource_form'],

  initialize: function(options) {
    this.model = new Resource();
    this.addSubview('#js-control-bar', new ControlBar({hideShareLink: true}));
    this.resourceTypes = new ResourceTypes();
    this.resourceTypes.fetch({success: this.render.bind(this)});
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
