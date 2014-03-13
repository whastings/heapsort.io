
module.exports = function(grunt) {
"use strict";

  var jsDir = 'app/assets/javascripts',
      browserifyCompiled = jsDir + '/app-compiled.js';

  var browserifyFiles = {};
  browserifyFiles[browserifyCompiled] = [
    jsDir + '/app.js'
  ];

  grunt.initConfig({
    browserify: {
      build: {
        files: browserifyFiles
      }
    },
    watch: {
      build: {
        files: [
          jsDir + '/app.js',
          jsDir + '/models/**/*.js',
          jsDir + '/views/**/*.js',
          jsDir + '/collections/**/*.js'
        ],
        tasks: ['build']
      }
    }
  });

  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('build', ['browserify:build']);
  grunt.registerTask('default', ['watch:build']);

};
