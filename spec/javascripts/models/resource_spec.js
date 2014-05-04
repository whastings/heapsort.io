"use strict";

var Comments = require('../src/collections/comments'),
    Resource = require('../src/models/resource'),
    resourceData = require('../data/resource_parse.json');

describe('Resource', function() {
  var resource;

  beforeEach(function() {
    resource = new Resource();
  });

  it('has a urlRoot set', function() {
    expect(resource.urlRoot).toBe('/api/resources');
  });

  describe('comments', function() {
    it('returns a collection of comments', function() {
      expect(resource.comments() instanceof Comments).toBe(true);
    });
  });

  describe('parse', function() {
    beforeEach(function() {
      resource.parse(_.clone(resourceData));
    });
    it('adds comments to resource', function() {
      resourceData.comments.forEach(function(comment, index) {
        var commentModel = resource.comments().at(index);
        expect(commentModel.get('content')).toBe(comment.content);
      });
    });
  });

  describe('ratingDisplay', function() {
    beforeEach(function() {
      resource.set('rating', 3);
    });

    it('prepends a "+" to positive ratings', function() {
      expect(resource.get('ratingDisplay')).toBe('+3');
    });

    it('updates as rating changes', function() {
      resource.set('rating', 5);
      expect(resource.get('ratingDisplay')).toBe('+5');
    });
  });
});
