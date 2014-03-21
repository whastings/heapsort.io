"use strict";

var CompoundView = require('../../support/compound_view'),
    Resource = require('../../models/resource'),
    Vote = require('../../models/vote');

var ResourcePage = module.exports = CompoundView.extend({
  bindings: {
    '#js-resource-rating': 'rating'
  },
  className: 'row',
  events: {
    'click #js-up-vote-btn': 'upVote',
    'click #js-down-vote-btn': 'downVote'
  },
  modelEvents: {
    'sync': 'render'
  },
  template: HandlebarsTemplates['pages/resource_page'],

  downVote: function(event) {
    event.preventDefault();
    recordVote.call(this, 'down');
  },

  initialize: function(options) {
    this.model = new Resource({id: options.resourceId});
    this.model.fetch();
  },

  render: function() {
    CompoundView.prototype.render.apply(this);
    this.stickit();

    return this;
  },

  upVote: function(event) {
    event.preventDefault();
    recordVote.call(this, 'up');
  }
});

var recordVote = function(direction) {
  var vote = new Vote({
    resource_id: this.model.id,
    direction: (direction === 'up') ? 1 : 0
  });
  vote.save({}, {success: updateResourceRating.bind(this)});
};

var updateResourceRating = function(vote, data) {
  this.model.set('rating', data.new_rating);
};
