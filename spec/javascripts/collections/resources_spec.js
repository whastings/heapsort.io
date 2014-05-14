"use strict";

var Resources = require('../src/collections/resources');

describe('Resources', function() {
  var resources,
      mockCategory;

  beforeEach(function() {
    mockCategory = {id: 1};
    resources = new Resources([], {category: mockCategory});
  });

  it('sets its category on initialize', function() {
    expect(resources.category).to.equal(mockCategory);
  });

  it('starts with its page number at 1', function() {
    expect(resources.page).to.equal(1);
  });

  describe('url', function() {
    it('constructs a url with its category id and page number', function() {
      var url = '/api/categories/' + mockCategory.id +
        '/resources?page=' + resources.page;
      expect(resources.url()).to.equal(url);
    });
  });
});
