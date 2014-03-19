Handlebars.registerHelper('get', function(attribute) {
  return new Handlebars.SafeString(this.get(attribute));
});
