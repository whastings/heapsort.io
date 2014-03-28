"use strict";

var ErrorDisplay = module.exports = {
  errorsTemplate: HandlebarsTemplates['errors'],

  hideErrors: function() {
    this.$(this.errorsElement).empty();
  },

  showErrors: function(errors) {
    this.$(this.errorsElement).html(this.errorsTemplate({errors: errors}));
  },

  showResponseErrors: function(model, response) {
    this.showErrors(response.responseJSON);
  }
};
