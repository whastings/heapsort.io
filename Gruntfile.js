
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
      },
      buildDev: {
        files: browserifyFiles,
        options: {
          debug: true
        }
      }
    },
    watch: {
      build: {
        files: [
          jsDir + '/app.js',
          jsDir + '/app_router.js',
          jsDir + '/models/**/*.js',
          jsDir + '/mixins/**/*.js',
          jsDir + '/support/**/*.js',
          jsDir + '/views/**/*.js',
          jsDir + '/collections/**/*.js'
        ],
        tasks: ['buildDev']
      }
    }
  });

  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('build', ['browserify:build']);
  grunt.registerTask('buildDev', ['browserify:buildDev']);
  grunt.registerTask('default', ['watch:build']);

};
