"use strict";

var Comment = require('../../models/comment');

var CommentForm = module.exports = Backbone.Marionette.ItemView.extend({
  events: {
    'submit': 'submit'
  },
  tagName: 'form',
  template: HandlebarsTemplates['resources/comment_form'],

  initialize: function(options) {
    this.model = new Comment({resource_id: options.resourceId});
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
