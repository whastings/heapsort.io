"use strict";

var Comment = require('../models/comment');

var Comments = module.exports = Backbone.Collection.extend({
  model: Comment
});
