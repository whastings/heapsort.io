var BookmarkShow = module.exports = Backbone.View.extend({

  template: HandlebarsTemplates['bookmarks/show'],

  render: function() {
    var content = this.template({bookmark: this.model.attributes});
    this.$el.html(content);
    return this;
  }

});
