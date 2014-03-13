var BookmarkTeaser = require('./bookmark_teaser');

var BookmarksListView = module.exports = Backbone.View.extend({

  render: function() {
    var self = this;
    this.collection.each(function(bookmark) {
      var view = new BookmarkTeaser({model: bookmark.attributes});
      self.$el.append(view.render().$el);
    });
    return this;
  }

});
