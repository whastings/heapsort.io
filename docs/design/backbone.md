# Backbone Plan

## Models

- Resource
- Category
- Tag
- Comment

## Collections

- Resources
- Categories
- Tags
- Comments

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
        * ResourceTeaser
    + BrowserControls

### Resource Show

- Use BasicControlBar
- ResourceShow < CompoundView
    + CommentForm
    + CommentsList

### Add a Resource

- Use BasicControlBar
- ResourceForm
    + CategorySelector

### Feed

### Favorites

## Mixins

- BackButton
