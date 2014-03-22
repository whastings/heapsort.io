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
- ControlBar
    + Includes "Share Resource" link, "Back" button
        * Both are optional to show.
    + Includes Feed, Favorites, & Settings nav links

### Home Page

- IndexControlBar < ControlBar
    + Extends ControlBar to add "drag to subscribe" and "drag to favorite"
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

- Use ControlBar
- ResourceShow < CompoundView
    + CommentForm
    + CommentsList

### Add a Resource

- Use ControlBar (with add resource off)
- ResourceForm
    + CategorySelector

### Feed

### Favorites

