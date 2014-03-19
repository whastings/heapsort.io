"use strict";

var CompoundView = module.exports = Backbone.Marionette.View.extend({

  addSubview: function(parentSelector, view) {
    view.parentSelector = parentSelector;
    this.subviews().push(view);
  },

  remove: function() {
    Backbone.View.prototype.remove.call(this);

    this.subviews().forEach(function(subview) {
      subview.remove();
    });
  },

  render: function() {
    if (this.template) {
      this.$el.html(this.template());
    }
    return this.renderSubviews();
  },

  renderSubviews: function() {
    var $parentEls = {},
        self = this;

    this.subviews().forEach(function(subview) {
      var parentSelector = subview.parentSelector;
      if (!$parentEls[parentSelector]) {
        $parentEls[parentSelector] = (parentSelector === '') ?
          self.$el : self.$(parentSelector);
        $parentEls[parentSelector].empty();
      }
      $parentEls[parentSelector].append(subview.render().$el);
      subview.delegateEvents();
    });
    return this;
  },

  subviews: function() {
    if (!this._subviews) {
      this._subviews = [];
    }
    return this._subviews;
  }

});
