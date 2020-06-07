
# Discuss Party
I want users to host a topic and then other people can comment on the topic and start a discussion. Users can mark topics public or private. Public discussions are available for everyone while private are only available for the people its shared with.

User model
- email
- has_many topics
- has_many categories through topics

Topic model
- title
- description
- belongs_to user
- status (public or private)
- belongs_to category

Comment model
- belongs_to User

Category model
- name
- has_many topics

## Permissions
### Public
- Topic owners can do everything with the post.
- Admins can do everything.
- Moderators can delete comments.
- Normal users can comment but cannot view topics that are private.
- Guests can view public topics.

## Gems
- Bootstrap

## Todo
- [x] Disable webpacker and start using sprockets
