# Discuss Party
![Contributions welcome](https://img.shields.io/badge/contributions-welcome-orange.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/aurangzaib-danial/discuss-party.svg?branch=master)](https://travis-ci.org/aurangzaib-danial/discuss-party)

Discuss party is a [reddit](https://www.reddit.com) + [dev.to](https://dev.to) style app. 
It allows people to have discussion on topics they love.
But if some one just loves writing, they can mark their topics private and share them with whoever they like.

## Motivaton
After completing my [Flatiron school's](https://flatironschool.com/) Rails module, I wanted to try out my newly gained skills in a full project. My initial plan was to make a marketplace and this project was just a sandbox for trying new ideas. But eventually, I realized that as I love writing why not evolve this sandbox into a real project.

## Backend built with
- [Ruby on Rails](https://github.com/rails/rails)
- [PostgreSQL database](https://www.postgresql.org)
- [Devise for authentication](https://github.com/rails/rails)
- [Pundit for authorization](https://github.com/varvet/pundit)
- [ActiveStorage for file management](https://github.com/rails/rails/tree/master/activestorage)
- [ActiveJob for asynchronous jobs in server](https://github.com/rails/rails/tree/master/activejob)
- [ActionMailer for emails](https://github.com/rails/rails/tree/master/actionmailer)
- [ActionText for storing rich text content](https://github.com/rails/rails/tree/master/actiontext)

# Frontend built with
- [Bootstrap 4](https://getbootstrap.com/docs/4.5/getting-started/introduction/)
- [Trix editor for rich text](https://github.com/basecamp/trix)

## Tested with
- [rspec-rails as the major test framework](https://github.com/rspec/rspec-rails)
- [Capybara for integration tests](https://github.com/teamcapybara/capybara)
- [Pundit matchers for testing authorization policies](https://github.com/chrisalley/pundit-matchers)
- [FactoryBot](https://github.com/thoughtbot/factory_bot)
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
- [Travis CI for contiuous integration](https://travis-ci.com)


## External API for production
[Amazon S3](https://aws.amazon.com/s3/) cloud storage is used by ActiveStorage for storing files in production.

## Features
### Code
Built with confidence using test driven development.

### Users in action
#### Accounts
Use regular sign\_in/sign\_up or use any of the four social login providers [Google](https://www.google.com/), [Twitter](https://twitter.com), [Github](https://www.github.com/) and [Facebook](https://www.facebook.com/).

#### Create
- Topics can be created with relevant tags and also their visibility can be made limited to either general public or private.
- Trix editor for creating RichText content for topics with attachments.
- Like/dislike based voting for topics.
- Easily manage sharing for private topics.

#### Browse
- Feed for viewing topics and then easily sorting them by latest, popular or oldest.
- Report feature for topics, allow users to easily report topics. Reported topics are hidden in users feed.
- Pagination for every long list.
- Search topics using fuzzy finder.

#### Profile
- Customize
- Profile pictures

#### URLS
Friendly URLS for easily sharing any aspect of application with others.

## Mature management system
Management system is available in application's menu-bar if a user has a **role** of either **admin** or **moderator**.
- Super admin
  - can only be set through console
  - create moderators through app management system.

- Moderators
  - can manage everything but do not have destructive options. 

### What staff can do?
- Reports management and taking action against topics.
- Users management i.e. blocking.
- Tags management (change tags color and CRUD)

## Planned features
- Use Ajax for voting, comments etc.
- Votes for comments (create polymorphic association on votes table and use it instead of topic_votes)
- Sort comments
- Use ActiveJob or may be sidekiq for uploading user profile pictures in the background
- Use infinite loading instead of pagination.
- Advanced search bar
- Save drafts as you type

## Useful Links
- [Live app](https://discuss-party.herokuapp.com)
- [Blog post](https://dev.to/aurangzaibdanial/discuss-party-1bg4)
- [Walkthrough + Code review'](https://youtu.be/AiHF9du42mo)

## Support
Reach out to me on twitter [@aurangzaib_dani](https://twitter.com/aurangzaib_dani)

## Contributing
1. Make sure you have [postgres](https://www.postgresql.org/) setup locally.
2. Install dependencies

```shell
$ bundle install
$ yarn install --check-files # for webpacker
```

3. Personally, I have sandbox apps with all social login providers and mail provider.
I use these sandbox API apps for testing in development mode.
You have to provide API keys otherwise the app will break.

```shell
$ rm config/credentials.yml.enc # remove previous encrypted credentials for using yours
$ rails credentials:edit #=> run again if it just generates master key for the first time
```
Write keys and secrets in the following pattern. 
Provide dummy values if you will but do not leave these empty.

```yaml
default: &default
  facebook:
    app_id: 123
    secret: 123abc 
  google:
    app_id: 123
    secret: 123abc
  github:
    app_id: 123
    secret: 123abc
  twitter:
    app_id: 123
    secret: 123abc
  mailer:
    user_name: mail-provider-key
    password: mail-provider-password
  bucket: aws-buckt-name

development:
  <<: *default

test:
  <<: *default
```
4. Run following commands in sequence to get going

```shell
$ rails db:setup #=> create db, load schema and some seed data
$ rails server #=> Hack away
```
Check `db/seeds.rb` for signing in as admin in development mode.

### Testing
rspec-rails is used as the testing framework.

```shell
$ bundle exec rspec
```
Test data is created using **FactoryBot**. Check out `spec/factories`

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
