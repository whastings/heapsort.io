
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
      },
      buildSpec: {
        files: {
          'spec/javascripts/compiled_spec.js': 'spec/javascripts/specs.js'
        },
        options: {
          transform: ['bulkify'],
          postBundleCB: function(error, src, next) {
            src = '//= require underscore\n//= require backbone\n' + src;
            next(error, src);
          }
        }
      }
    },
    shell: {
      runSpecs: {
        command: 'bundle exec rake konacha:serve SPEC=compiled_spec',
        options: {
          failOnError: true,
          stderr: true,
          stdout: true
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
      },
      buildSpecs: {
        files: ['spec/javascripts/models/*.js'],
        tasks: ['buildSpec']
      }
    }
  });

  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-shell');

  grunt.registerTask('build', ['browserify:build']);
  grunt.registerTask('buildDev', ['browserify:buildDev']);
  grunt.registerTask('buildSpec', ['browserify:buildSpec']);
  grunt.registerTask('default', ['watch:build']);
  grunt.registerTask('specs', ['buildSpec', 'shell:runSpecs']);
  grunt.registerTask('watchSpecs', ['watch:buildSpecs']);

};
