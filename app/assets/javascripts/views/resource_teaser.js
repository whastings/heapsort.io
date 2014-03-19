var ResourceTeaser = module.exports = Backbone.View.extend({

  template: HandlebarsTemplates['resources/teaser'],

  render: function() {
    var content = this.template({resource: this.model});
    this.$el.html(content);
    return this;
  }

});
