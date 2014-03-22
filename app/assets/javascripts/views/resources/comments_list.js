"use strict";

var CommentsList = module.exports = Backbone.Marionette.ItemView.extend({
  collectionEvents: {
    'add': 'render'
  },
  tagName: 'ul',
  template: HandlebarsTemplates['resources/comments_list']
});
