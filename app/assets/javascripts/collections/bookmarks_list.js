var Bookmark = require('../models/bookmark');

var BookmarksList = module.exports = Backbone.Collection.extend({

  url: '/api/bookmarks',
  model: Bookmark

});
