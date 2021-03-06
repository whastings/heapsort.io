"use strict";

var CommentForm = require('../resources/comment_form'),
    CommentsList = require('../resources/comments_list'),
    CompoundView = require('../../support/compound_view'),
    ControlBar = require('../control_bars/control_bar'),
    FavoriteControls = require('../../mixins/favorite_controls'),
    notice = require('../../support/notice'),
    Resource = require('../../models/resource'),
    utils = require('../../support/utils'),
    Vote = require('../../models/vote');

var ResourcePage = module.exports = CompoundView.extend({
  bindings: {
    '#js-resource-rating': 'ratingDisplay'
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
    this.model = new Resource({friendly_id: options.resourceId});
    this.model.fetchByFriendlyId();
    this.addSubview(
      '#js-control-bar',
      new ControlBar()
    );
    this.addSubview(
      '#js-comment-form',
      new CommentForm({
        resource: this.model,
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
  var self = this;
  if (!utils.isSignedIn()) {
    return notice.requestSignIn('vote on resources');
  }
  var vote = new Vote({
    resource_id: this.model.id,
    direction: (direction === 'up') ? 1 : 0
  });
  vote.save({}, {
    success: function(vote, data) {
      updateResourceRating.call(self, vote, data);
      notice.display('Vote recorded!');
    },
    error: function() {
      notice.display('Sorry, that vote is invalid.');
    }
  });
};

var updateResourceRating = function(vote, data) {
  this.model.set('rating', data.new_rating);
};
