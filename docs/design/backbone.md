# Backbone Plan

## Models

- Resource
    + urlRoot: /api/resources
    + tags
    + comments
- Category
    + urlRoot: /api/categories
    + childCategories
    + resources
- Tag
- Comment
    + urlRoot: /api/resources/[resource_id]

## Collections

- Resources
    + url: /api/categories/[category_id]/resources
- Categories
    + url: /api/categories
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
    + Events:
        * favorite resource
        * subscribe to category
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
