"use strict";

var responsive = require('../../support/responsive'),
    transitionHelper = require('../../support/transition_helper');

var CategoriesList = module.exports = Backbone.Marionette.ItemView.extend({
  animationTime: 500,
  tagName: 'ul',
  template: HandlebarsTemplates['categories/categories_list'],
  templateHelpers: {},

  initialize: function(options) {
    this.templateHelpers.parentCategory = options.parentCategory.attributes;
    this.currentCategoryId = options.parentCategory.id;
    this.renderedOnce = false;
  },

  render: function() {
    if (!this.collection.length && !this.empty) {
      return this;
    }
    var data = this.serializeData();
    data = this.mixinTemplateHelpers(data);
    var content = Backbone.Marionette.Renderer.render(this.template, data);
    if (!this.renderedOnce || responsive.maxWidth('screen-md')) {
      this.$el.html(content);
      this.renderedOnce = true;
    } else {
      this.childTransition ? animateChildTransition.call(this, content) :
        animateParentTransition.call(this, content);
    }
    this.$('.category-link').draggable({
      helper: 'clone',
      opacity: 0.7,
      appendTo: $('#js-content')
    });
    return this;
  },

  transition: function(newCategory) {
    if (this.currentCategoryId === undefined ||
        this.currentCategoryId === null ||
        newCategory.get('parent_id') === this.currentCategoryId) {
      this.childTransition = true;
    } else {
      this.childTransition = false;
    }
    this.currentCategoryId = newCategory.id || 0;
    this.collection = newCategory.children();
    if (!this.collection.length) {
      this.empty = true;
    } else {
      this.empty = false;
    }
    this.templateHelpers.parentCategory = newCategory.attributes;
    this.render();
  }
});

var animateChildTransition = function(content) {
  animateTransition.call(this, content, 1);
};

var animateParentTransition = function(content) {
  animateTransition.call(this, content, -1);
};

var animateTransition = function(content, direction) {
  var self = this,
      $oldEl = this.$el,
      currentHeight = $oldEl.height() + 10,
      currentWidth = $oldEl.width() + 15,
      startTransitionX = (currentWidth * direction) + 'px',
      endTransitionX = (currentWidth * direction * -1) + 'px',
      transitionY = (currentHeight * -1) + 'px';
  this.$el = this.$el.clone().html(content);
  transitionHelper.addTransform(
    this.$el,
    'translate',
    startTransitionX,
    transitionY
  );
  this.$el.insertAfter($oldEl);
  this.$el.get(0).offsetWidth; // Force relayout.
  this.$el.addClass('list-animating');
  $oldEl.addClass('list-animating');
  transitionHelper.addTransform($oldEl, 'translate', endTransitionX, 0);
  transitionHelper.addTransform(this.$el, 'translate', 0, (currentHeight * -1) + 'px');
  transitionHelper.onTransitionEnd(this.$el, this.animationTime, function() {
    self.$el.removeAttr('style');
    $oldEl.remove();
    self.$el.removeClass('list-animating');
  });
};
