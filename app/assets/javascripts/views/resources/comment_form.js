"use strict";

var Comment = require('../../models/comment'),
    utils = require('../../support/utils');

var CommentForm = module.exports = Backbone.Marionette.ItemView.extend({
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
    var content = this.$('#js-comment-content').val();
    this.model.save({content: content}, {success: handleSuccess.bind(this)});
  }
});

var handleSuccess = function(model) {
  this.collection.add(model);
  this.$el[0].reset();
};
