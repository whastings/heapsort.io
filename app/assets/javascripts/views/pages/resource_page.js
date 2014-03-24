"use strict";

var CommentForm = require('../resources/comment_form'),
    CommentsList = require('../resources/comments_list'),
    CompoundView = require('../../support/compound_view'),
    ControlBar = require('../control_bars/control_bar'),
    FavoriteControls = require('../../mixins/favorite_controls'),
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
    'favorited': 'render',
    'sync': 'render',
    'unfavorited': 'render'
  },
  template: HandlebarsTemplates['pages/resource_page'],

  downVote: function(event) {
    event.preventDefault();
    recordVote.call(this, 'down');
  },

  initialize: function(options) {
    this.model = new Resource({id: options.resourceId});
    this.model.fetch();
    this.addSubview(
      '#js-control-bar',
      new ControlBar()
    );
    this.addSubview(
      '#js-comment-form',
      new CommentForm({
        resourceId: this.model.id,
        collection: this.model.comments()
      })
    );
    this.addSubview(
      '#js-comments-list',
      new CommentsList({collection: this.model.comments()})
    );
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

$.extend(true, ResourcePage.prototype, FavoriteControls);

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
