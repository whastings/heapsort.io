# Routes

## API

### Resources

- POST /api/resources: Create resource
- GET /api/resources/:id: Show resource
    + Should include all resource data, including description
    + Should include comments
- PATCH /api/resources/:id: Update resource

### Categories

- GET /api/categories/:category_id/resources: Resource index, page 1
- GET /api/categories/:category_id/resources/:page: Resource index, page *n*
- GET /api/categories/:id: Category show
    + Should include:
        * Titles and IDs for child categories.
        * Page 1 of resources with title, url, user, time, votes, tags.

### Feed

- GET /api/feed: User's subscriptions feed
    + Should return teaser data for each bookmark

### User Subscription

- POST /api/user_subscriptions: Add a user subscription
- DELETE /api/user_subscriptions/:id: Delete a user subscription

### Category Subscription

- POST /api/categories/:category_id/category_subscriptions: Add a category subscription
- DELETE /api/category_subscriptions/:id: Delete a category subscription
- GET /api/category_subscriptions: Subscriptions Index

### Favorites

- GET /api/favorites: User's favorite resources index
- POST /api/favorites: Add a favorite.
- DELETE /api/favorites: Delete a favorite.

### Comments

- POST /api/resources/:resource_id/comments: Add a comment

### Votes

- POST /api/resources/:resource_id/votes: Vote on a resource

