# Backbone Plan

## Models

- Resource
- Category

## Collections

- Resources
- Categories

## Views

**Note**: Consider having all single-item views extend from Marionette's `ItemView`

### General

- CompoundView
    + To give extending views ability to render subviews
    + Methods: addSubview, removeSubview, remove, renderSubviews
- ControlBar
- BasicControlBar < ControlBar
    + Includes "Add Resource" link

### Home Page

- IndexControlBar < ControlBar
- CategoryBrowser
    + CategoriesList
        * Subview needed for each category???
    + ResourcesList < CollectionView
        * Have separate template for single bookmark teaser
        * Subview needed for single bookmark teaser???
            - Might make sorting more difficult
    + BrowserControls

### Resource Show

- Use BasicControlBar
- ResourceShow < CompoundView
    + CommentForm
    + CommentsList

## Mixins

- BackButton
