FactoryBot.define do
  factory(:topic) do
    title { 'This is a superb topic for discussion'}
    description { Faker::Lorem.paragraph }
    user { build(:user) }
    topic_tags do
      2.times.collect do
        TopicTag.new(tag: build(:tag))
      end
    end
  end
end
