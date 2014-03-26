"use strict";

var Categories = require('../../collections/categories'),
    CategoryDictionary = require('../../support/category_dictionary');

var CategorySelector = module.exports = Backbone.View.extend({
  className: 'category-selector clearfix',
  events: {
    'click .category-link': 'changeCategory'
  },
  template: HandlebarsTemplates['categories/category_selector'],

  changeCategory: function(event) {
    event.preventDefault();
    var $newCategoryLink = $(event.target);
    $newCategoryLink.addClass('selected');
    switchCategories.call(this, $newCategoryLink);
    this.render();
  },

  initialize: function() {
    this.collection = new Categories();
    this.dictionary = CategoryDictionary.create(this.collection);
    this.listenTo(this.dictionary, 'reset', this.render);
    this.collection.fetch();
    this.currentCategory = 0;
    this.renderedCategories = [];
  },

  render: function() {
    var children = this.dictionary.getChildren(this.currentCategory);
    if (!children || _.contains(this.renderedCategories, this.currentCategory)) {
      return this;
    }
    var $newColumn = $(this.template({children: toPojoArray(children)}));
    $newColumn.$parentColumn = this.$column;
    $newColumn.categoryId = this.currentCategory;
    this.$column = $newColumn;
    this.$el.append(this.$column);
    this.renderedCategories.push(this.currentCategory);
    return this;
  }
});

var removeColumns = function($column, targetId) {
  if (!$column.$parentColumn || $column.categoryId === targetId) {
    return;
  }
  $column.remove();
  removeColumns($column.$parentColumn, targetId);
};

// If new category isn't a child of current one, remove current.
var switchCategories = function($newCategoryLink) {
  var newCategoryId = $newCategoryLink.data('id');
  var parentId = parseInt(this.collection.get(newCategoryId).get('parent_id'));
  if (this.currentCategory !== parentId && this.currentCategory > 0) {
    removeColumns.call(this, this.$column, parentId);
  }
  this.currentCategory = newCategoryId;
};

var toPojoArray = function(array) {
  return _.map(array, function(element) {
    return element.toJSON();
  });
};

