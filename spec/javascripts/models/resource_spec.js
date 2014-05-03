"use strict";

var Resource = require('../src/models/resource');

describe('Resource', function() {
  it('has a urlRoot set', function() {
    expect(Resource.prototype.urlRoot).toBe('/api/resources');
  });
});
