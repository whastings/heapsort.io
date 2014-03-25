# Models

## User
- Associations:
    + has_many comments, votes, user_subscriptions, category_subscriptions, favorites
    + has_many favorited_resources through favorites
    + has_one session
- Attributes:
    + username: required, unique
    + email: required, unique
    + password_digest: required
    + last_sign_in (timestamp)
    + admin (boolean)
    + blocked (boolean)
    + profile: TBD
- Indexes:
    + username
    + email

## Session
- Associations:
    + belongs_to user
- Attributes:
    + user_id: required
    + token (encrypted): required, unique
- Indexes:
    + token

## Resource:
- Associations:
    + has_many comments, votes, favorites, taggings, reports
    + has_many tags through taggings
    + belongs_to user, category, resource_type
- Attributes:
    + title: required
    + domain: required
    + path: required
    + query_string
    + port: required, default: 80
    + protocol (http or https): required, default: http
    + category_id: required
    + resource_type_id: required
    + description
    + user_id: required
Indexes:
    + category_id
    + domain
    + path
    + user_id
    + resource_type_id

## Comment:
- Associations:
    + belongs_to user, resource
- Attributes:
    + content: required
    + resource_id: required
    + user_id: required
- Indexes:
    + resource_id
    + user_id

## Vote
- Associations:
    + belongs_to user, resource
- Attributes:
    + direction (up or down): required
    + resource_id: required
    + user_id: required
- Indexes:
    + resource_id

## Category
- Associations:
    + belongs_to parent_category
    + has_many children, resources
- Attributes:
    + name: required
    + parent_id
- Indexes:
    + parent_id
    + [name, parent_id], unique: true

## ResourceType
- (e.g. article, tutorial, reference, video, video tutorial)
- Associations:
    + has_many resources
- Attributes:
    + name: required

## UserSubscription
- Associations:
    + belongs_to subscriber, user
- Attributes:
    + subscriber_id: required
    + user_id: required
- Indexes:
    + subscriber_id

## CategorySubscription
- Associations
    + belongs_to subscriber, user
- Attributes:
    + subscriber_id: required
    + category_id: required
- Indexes
    + subscriber_id

## Favorite
- Associations:
    + belongs_to user, resource
- Attributes:
    + resource_id: required
    + user_id: required
- Indexes:
    + user_id

## Report
- Associations:
    + belongs_to user, resource
- Attributes:
    + resource_id: required
    + user_id (user making the report): required
    + type (duplicate, inappropriate, spam, miscategorized): required
        * Need Report Type model???

## Tag
- Attributes:
    + name: required

## Tagging
- Associations:
    + belongs_to tag, resource
- Attributes:
    + tag_id: required
    + resource_id: required
- Indexes:
    + tag_id
    + resource_id

