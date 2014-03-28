"use strict";

var Comment = require('../../models/comment'),
    ErrorDisplay = require('../../mixins/error_display'),
    utils = require('../../support/utils');

var CommentForm = module.exports = Backbone.Marionette.ItemView.extend({
  errorsElement: '#js-comment-form-errors',
  events: {
    'submit': 'submit'
  },
  tagName: 'form',
  template: HandlebarsTemplates['resources/comment_form'],
  templateHelpers: {
    isSignedIn: utils.isSignedIn()
  },

  initialize: function(options) {
    this.model = new Comment();
    this.model.resource = options.resource;
  },

  submit: function(event) {
    event.preventDefault();
    this.hideErrors();
    var content = this.$('#js-comment-content').val();
    this.model.save(
      {content: content},
      {
        success: handleSuccess.bind(this),
        error: this.showResponseErrors.bind(this)
      }
    );
  }
});

_.extend(CommentForm.prototype, ErrorDisplay);

var handleSuccess = function(model) {
  this.collection.add(model);
  this.$el[0].reset();
};
