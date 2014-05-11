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
      expect(category.children()).to.be.an.instanceof(Categories);
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
      expect(category.children()).to.have.length(0);
      expect(category.resources()).to.have.length(0);
    });
  });

  describe('parse', function() {
    var parseResult;

    beforeEach(function() {
      parseResult = category.parse(_.clone(categoryData));
    });

    it('assigns a total count to its resources', function() {
      expect(category.resources().total).to.equal(categoryData.resources_count);
    });

    it('assigns its category id to its resources', function() {
      expect(category.resources().categoryId).to.equal(categoryData.id);
    });

    it('adds children to category', function() {
      categoryData.children.forEach(function(child) {
        var childModel = category.children().get(child.id);
        expect(childModel).to.be.an.instanceof(Category);
        expect(childModel.get('name')).to.equal(child.name);
      });
    });

    it('adds resources to category', function() {
      categoryData.resources.forEach(function(resource) {
        var resourceModel = category.resources().get(resource.id);
        expect(resourceModel).to.be.an.instanceof(Resource);
        expect(resourceModel.get('title')).to.equal(resource.title);
      });
    });

    it('sets parent_id to 0 if category is top-level', function() {
      expect(parseResult.parent_id).to.equal(0);
    });
  });

  describe('resources', function() {
    it('returns a collection of resources', function() {
      expect(category.resources()).to.be.an.instanceof(Resources);
    });
  });
});
