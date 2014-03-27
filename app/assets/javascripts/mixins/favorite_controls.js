"use strict";

var Favorite = require('../models/favorite'),
    notice = require('../support/notice'),
    utils = require('../support/utils');

var FavoriteControls = module.exports = {
  events: {
    'click .js-add-favorite-btn': 'favorite',
    'click .js-remove-favorite-btn': 'unfavorite'
  },

  favorite: function(event) {
    if (!utils.isSignedIn()) {
      return notice.requestSignIn('favorite resources');
    }
    var self = this;
    event.preventDefault();
    var resourceId = this.model.id;
    var favorite = new Favorite({resource_id: resourceId});
    favorite.save({}, {success: function(favorite) {
      self.model.set('favorite_id', favorite.id);
      self.model.trigger('favorited', self.model);
    }});
  },

  unfavorite: function(event) {
    var self = this;
    event.preventDefault();
    var favorite = new Favorite({id: this.model.get('favorite_id')});
    favorite.destroy({success: function() {
      self.render();
      self.model.set('favorite_id', null);
      self.model.trigger('unfavorited', self.model);
    }});
  }
};
