var BookmarksList = require('./collections/bookmarks_list'),
    BookmarksListView = require('./views/bookmarks_list_view');

$(function() {

  var list = new BookmarksList();
  list.fetch({
    success: function() {
      var view = new BookmarksListView({collection: list});
      $('#js-content').html(view.render().$el);
    }
  });

});
