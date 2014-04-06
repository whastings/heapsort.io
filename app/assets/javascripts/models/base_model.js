"use strict";

var BaseModel = module.exports = Backbone.Model.extend({
  expire: function() {

  },

  fetchByFriendlyId: function(options) {
    var self = this;
    options = options || {};
    this.url = this.urlRoot + '/' + this.get('friendly_id');
    this.fetch({success: function() {
      delete self.url;
      options.success && options.success();
    }});
  },

  sync: function(method, model, options) {
    if (method !== 'read') {
      return Backbone.sync.apply(this, arguments);
    }
    var cacheName = this.cachePrefix + model.id;
    var cachedValue = window.localStorage[cacheName];
    if (cachedValue === undefined) {
      cachedValue = Backbone.sync.apply(this, arguments);
      window.localStorage[cacheName] = cachedValue;
    }
    // How do I pass cachedValue to model's parse?
  }
});
