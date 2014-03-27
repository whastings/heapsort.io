"use strict";

var BaseModel = module.exports = Backbone.Model.extend({
  fetchByFriendlyId: function(options) {
    var self = this;
    options = options || {};
    this.url = this.urlRoot + '/' + this.get('friendly_id');
    this.fetch({success: function() {
      delete self.url;
      options.success && options.success();
    }});
  }
});
