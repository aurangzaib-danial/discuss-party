source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Authentication
gem 'devise', '~> 4.7'
gem "omniauth-github", "~> 1.4"
gem "omniauth-facebook", "~> 6.0"
gem "omniauth-google-oauth2", "~> 0.8.0"
gem "omniauth-twitter", "~> 1.4"

# Authorization
gem 'pundit', '~> 2.1'

# Assets
gem 'sass-rails', '>= 6'
gem "webpacker", "~> 4.2.2"


#pagination
gem "kaminari", "~> 1.2"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Active Record extensions
gem "strip_attributes", '~> 1.11.0'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'active_storage_validations', '~> 0.8.9'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 4.0.1'
  gem 'faker', '~> 2.13'
  gem 'capybara', '~> 3.33'
  gem 'factory_bot_rails', '~> 6.1'
  gem 'pry', '~> 0.13.1'
end

group :test do
  gem 'shoulda-matchers', '~> 4.3.0'
  gem 'pundit-matchers', '~> 1.6.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rails-erd', '~> 1.6.0'
  gem "immigrant", "~> 0.3.6"
  gem 'hirb', '~> 0.7.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'valid_email', require: ['valid_email/all_with_extensions']

gem "down", "~> 5.1"
