"use strict";

var responsive = require('../../support/responsive');

var CategoriesList = module.exports = Backbone.Marionette.ItemView.extend({
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
  animateTransition.call(
    this,
    content,
    'child-transitioning-in',
    'parent-transitioning-out',
    (this.$el.parent().width() * -1) - 15
  );
};

var animateParentTransition = function(content) {
  animateTransition.call(
    this,
    content,
    'parent-transitioning-in',
    'child-transitioning-out',
    this.$el.parent().width() + 15
  );
};

var animateTransition = function(content, inClass, outClass, widthCallback) {
  var self = this;
  var $oldEl = this.$el;
  var $container = this.$el.parent();
  this.$el = this.$el.clone().html(content);
  this.$el.removeAttr('style');
  $oldEl.removeAttr('style');
  this.$el.addClass(inClass);
  this.$el.insertAfter($oldEl);
  this.$el.width($container.width() - 1);
  var containerHeight = Math.max($oldEl.height(), this.$el.height());
  $container.css('height', containerHeight + 25);
  $oldEl.addClass(outClass);
  $oldEl.animate({
    left: widthCallback
  }, 500, function() {
    $oldEl.remove();
  });
  this.$el.animate({
    left: 15
  }, 500, function() {
    self.$el.removeClass(inClass);
  });
};
