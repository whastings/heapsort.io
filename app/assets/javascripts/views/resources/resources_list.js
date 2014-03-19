"use strict";

var ResourceTeaser = require('./resource_teaser');

var ResourcesListView = module.exports = Backbone.Marionette.CollectionView.extend({
  itemView: ResourceTeaser

});
