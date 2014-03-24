"use strict";

var CategorySubscription = module.exports = Backbone.Model.extend({
  url: function() {
    return '/api/categories/' + this.get('category_id') +
      '/category_subscriptions';
  }
});
