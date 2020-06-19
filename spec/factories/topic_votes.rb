FactoryBot.define do
  factory :topic_vote do
    vote { 1 }
    topic { nil }
    user { nil }
  end
end
