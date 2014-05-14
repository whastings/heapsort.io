"use strict";

var bulk = require('bulk-require');
var specs = bulk(__dirname, [
  'models/*_spec.js',
  'collections/*_spec.js'
]);
