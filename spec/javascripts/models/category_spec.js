"use strict";

var Category = require('../src/models/category'),
    Categories = require('../src/collections/categories'),
    categoryData = require('../data/category_parse.json'),
    Resource = require('../src/models/resource'),
    Resources = require('../src/collections/resources');

describe('Category', function() {
  var category;

  beforeEach(function() {
    category = new Category({id: categoryData.id});
  });

  describe('children', function() {
    it('returns a collection of categories', function() {
      expect(category.children() instanceof Categories).toBe(true);
    });
  });

  describe('empty', function() {
    beforeEach(function() {
      _.times(3, function() {
        category.children().push({});
        category.resources().push({});
      });
    });

    it('clears out children and resources', function() {
      category.empty();
      expect(category.children().length).toBe(0);
      expect(category.resources().length).toBe(0);
    });
  });

  describe('parse', function() {
    var parseResult;

    beforeEach(function() {
      parseResult = category.parse(_.clone(categoryData));
    });

    it('assigns a total count to its resources', function() {
      expect(category.resources().total).toBe(categoryData.resources_count);
    });

    it('assigns its category id to its resources', function() {
      expect(category.resources().categoryId).toBe(categoryData.id);
    });

    it('adds children to category', function() {
      categoryData.children.forEach(function(child) {
        var childModel = category.children().get(child.id);
        expect(childModel instanceof Category).toBe(true);
        expect(childModel.get('name')).toBe(child.name);
      });
    });

    it('adds resources to category', function() {
      categoryData.resources.forEach(function(resource) {
        var resourceModel = category.resources().get(resource.id);
        expect(resourceModel instanceof Resource).toBe(true);
        expect(resourceModel.get('title')).toBe(resource.title);
      });
    });

    it('sets parent_id to 0 if category is top-level', function() {
      expect(parseResult.parent_id).toBe(0);
    });
  });

  describe('resources', function() {
    it('returns a collection of resources', function() {
      expect(category.resources() instanceof Resources).toBe(true);
    });
  });
});
