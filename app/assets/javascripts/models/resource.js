"use strict";

var Comment = require('./comment'),
    Comments = require('../collections/comments');

var Resource = module.exports = Backbone.Model.extend({
  urlRoot: '/api/resources',

  comments: function() {
    return this._comments || (this._comments = new Comments());
  },

  parse: function(data) {
    var comments = this.comments();
    if (Array.isArray(data.comments)) {
      data.comments.forEach(function(comment) {
        comments.add(new Comment(comment));
      });
      delete data.comments;
    }

    return data;
  }
});
