var ResourcesList = require('./collections/resources_list'),
    ResourcesListView = require('./views/resources_list_view');

$(function() {

  var list = new ResourcesList();
  list.fetch({
    success: function() {
      var view = new ResourcesListView({collection: list});
      $('#js-content').html(view.render().$el);
    }
  });

});
