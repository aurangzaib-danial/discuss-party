
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
- has_many tags through topic_tags

Comment model
- belongs_to User

Tag model
- name
- has_many topics through topic_tags

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
- [x] Add a menubar
- [x] Setup Devise
- [x] Setup topic model
- [x] Print topics on root page
- [x] Use Faker gem for making some topics
- [x] Users can create topics
    - [x] Slugs for topic titles
- [x] Display latest topics on root

## Todo Maybe
- [x] Highlight current page
- [x] User should have a name as well

## Comment Feature
- Setup backend (done)
- Write a form based based on comment model and use nested resource for topics
- Only allow signed_in users to launch a post request to comments create
- List all the comments by latest
