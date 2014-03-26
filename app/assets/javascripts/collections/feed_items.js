"use strict";

var Resources = require('./resources');

var FeedItems = module.exports = Resources.extend({
  url: function() {
    return '/api/feed?page=' + this.page;
  }
});
