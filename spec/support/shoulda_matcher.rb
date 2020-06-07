Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails #=> adds all matchers ActiveRecord, Controller etc.
  end
end
