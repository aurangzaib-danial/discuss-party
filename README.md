# Discuss Party
Dicuss pary is an application where people can have discussion on topics they love.

>This is my portfolio project that I have built after completing my Ruby on Rails module on Flatiron school.

## Languages and Frameworks used
1. Ruby
2. HTML
3. CSS
4. Ruby on Rails

This project is built in pure Ruby on Rails code, Javascript is not used.

## Features
- Built with confidence using test driven development.
- Devise based authentication with multiple social login providers.
- Topics can be created with relevant tags and also their visibility can be made limited to either general public or private.
- Friendly URLS for easily sharing any aspect of application with others.
- Trix editor for creating RichText content for topics with attachments.
- Feed for viewing topics and then easily sorting them either latest, popular or oldest.
- Like/dislike based voting feature for topics.
- Easily manage sharing for private topics.
- Report feature for topics, allow users to easily report topics. Reported topics are hidden in users feed
- Users can have profile pictures and all their profiles can be edited.
- Pagination for every long list.


### Mature management system for managing various aspects of the application.
- Super admin (can only be set through console)
- Moderators, can manage everything but do not have destructive options. Also, super admin can easily create new moderators using the applicaiton.
- Reports management and taking action against topics.
- Users management i.e. blocking.

aws Cloud


### Future features
- Use Ajax for voting, comments etc.
- Votes for comments (create polymorphic association on votes table and use it instead of topic_votes)
- Sort comments
- Use ActiveJob or may be sidekiq for uploading user profile pictures in the background
- Use infinite loading instead of pagination.
