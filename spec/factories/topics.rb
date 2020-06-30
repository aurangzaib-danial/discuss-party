FactoryBot.define do
  factory(:topic) do
    sequence(:title) { |n| "The topic is #{n}" }
    description { Faker::Lorem.paragraph }
    creator { build(:user) }
    topic_tags do
      2.times.collect { TopicTag.new(tag: build(:tag)) }
    end
  end
end
