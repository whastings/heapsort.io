"use strict";

var Notice = Backbone.View.extend({
  className: 'notice',
  template: HandlebarsTemplates['notice'],

  initialize: function(options) {
    this.message = options.message;
  },

  render: function() {
    var content = this.template({message: this.message});
    this.$el.html(content);
    return this;
  }
});

var display = exports.display = function(message) {
  var notice = new Notice({message: message});
  $('body').append(notice.render().$el);
  notice.$el.fadeIn('fast');
  window.setTimeout(function() {
    notice.$el.fadeOut('fast');
  }, 4000);
};

exports.requestSignIn = function(action) {
  display('Please sign in to ' + action + '.');
};
