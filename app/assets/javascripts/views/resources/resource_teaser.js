"use strict";

var Favorite = require('../../models/favorite');

var ResourceTeaser = module.exports = Backbone.Marionette.ItemView.extend({
  events: {
    'click .js-remove-favorite-btn': 'unfavorite'
  },
  template: HandlebarsTemplates['resources/teaser'],

  unfavorite: function(event) {
    var self = this;
    event.preventDefault();
    var favorite = new Favorite({id: this.model.get('favorite_id')});
    favorite.destroy({success: function() {
      self.render();
      self.model.trigger('unfavorited', self.model);
    }});
  }
});
