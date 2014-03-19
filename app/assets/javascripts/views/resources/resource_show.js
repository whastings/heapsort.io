var ResourceShow = module.exports = Backbone.View.extend({

  template: HandlebarsTemplates['resources/show'],

  render: function() {
    var content = this.template({resource: this.model.attributes});
    this.$el.html(content);
    return this;
  }

});
