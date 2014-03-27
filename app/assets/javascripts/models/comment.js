"use strict";

var Comment = module.exports = Backbone.Model.extend({
  url: function() {
    return '/api/resources/' + this.resource.get('id') + '/comments';
  }
});
