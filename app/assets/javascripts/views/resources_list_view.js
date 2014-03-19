var ResourceTeaser = require('./resource_teaser');

var ResourcesListView = module.exports = Backbone.View.extend({

  render: function() {
    var self = this;
    this.collection.each(function(resource) {
      var view = new ResourceTeaser({model: resource.attributes});
      self.$el.append(view.render().$el);
    });
    return this;
  }

});
