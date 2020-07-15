FactoryBot.define do
  factory(:topic) do
    sequence(:title) { |n| "The topic is #{n}" }
    description { Faker::Lorem.paragraph }
    creator { build(:user) }
  end
end
