var BookmarkTeaser = module.exports = Backbone.View.extend({

  template: HandlebarsTemplates['bookmarks/teaser'],

  render: function() {
    var content = this.template({bookmark: this.model});
    this.$el.html(content);
    return this;
  }

});
