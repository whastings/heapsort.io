"use strict";

var ResourceTeaser = require('./resource_teaser');

var ResourcesListView = module.exports = Backbone.Marionette.CollectionView.extend({
  events: {
    'click #js-resource-page-btn': 'loadPage'
  },
  itemView: ResourceTeaser,

  loadPage: function() {
    this.collection.fetchNextPage();
  },

  onAfterItemAdded: function(resourceView) {
    if (this.collection.length < this.collection.total) {
      if (!this.$pageButton) {
        this.$pageButton = loadMoreButton();
      }
      this.$pageButton.insertAfter(resourceView.$el);
    } else {
      this.$pageButton && this.$pageButton.remove();
    }
    resourceView.$el.draggable({helper: 'clone', opacity: 0.7});
  }
});

var loadMoreButton = function() {
  var $button = $('<button>');
  $button.text('Load More');
  $button.addClass('resource-page-btn');
  $button.attr('id', 'js-resource-page-btn');
  return $button;
};
