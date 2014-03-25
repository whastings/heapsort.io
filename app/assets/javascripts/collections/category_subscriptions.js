"use strict";

var CategorySubscription = require('../models/category_subscription');

var CategorySubscriptions = module.exports = Backbone.Collection.extend({
  model: CategorySubscription,
  url: '/api/category_subscriptions'
});
