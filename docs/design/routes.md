# Routes

## API

### Resources

- GET /api/categories/:category_id/resources: Resource index, page 1
- GET /api/categories/:category_id/resources/:page: Resource index, page *n*
- POST /api/resources: Create resource
- GET /api/resources/:id: Show resource
- PATCH /api/resources/:id: Update resource

### Categories

- GET /api/categories/:id: Category show
    + Should include data for child categories and page 1 of resources.

### Feed

- GET /api/feed: User's subscriptions feed

### User Subscription

- POST /api/user_subscriptions: Add a user subscription
- DELETE /api/user_subscriptions/:id: Delete a user subscription

### Category Subscription

- POST /api/category_subscriptions: Add a category subscription
- DELETE /api/category_subscriptions/:id: Delete a category subscription

### Favorites

- GET /api/favorites: User's favorite resources index
- POST /api/favorites: Add a favorite.
- DELETE /api/favorites: Delete a favorite.

### Comments

- POST /api/resources/:resource_id/comments: Add a comment

### Votes

- POST /api/resources/:resource_id/votes: Vote on a resource

