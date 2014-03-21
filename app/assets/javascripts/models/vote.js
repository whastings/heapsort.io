"use strict";

var Vote = module.exports = Backbone.Model.extend({
  url: function() {
    return '/api/resources/' + this.get('resource_id') + '/votes';
  }
});
