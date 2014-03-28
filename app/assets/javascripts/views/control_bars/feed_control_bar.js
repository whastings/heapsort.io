"use strict";

var CategorySubscriptions = require('../../collections/category_subscriptions');

var FeedControlBar = module.exports = Backbone.Marionette.ItemView.extend({
  collectionEvents: {
    'remove': 'render',
    'sync': 'render'
  },
  events: {
    'click .js-remove-catsub-btn': 'removeCategorySubscription'
  },
  template: HandlebarsTemplates['control_bars/feed_control_bar'],

  initialize: function(options) {
    this.feedItems = options.feedItems;
    this.collection = new CategorySubscriptions();
    this.collection.fetch();
  },

  removeCategorySubscription: function(event) {
    var self = this;
    event.preventDefault();
    var subscriptionId = $(event.target).data('id');
    var subscription = this.collection.get(subscriptionId);
    subscription.destroy({success: function() {
      self.collection.remove(subscription);
      self.feedItems.reset();
      self.feedItems.fetch();
    }});
  }
});
