FactoryBot.define do
  factory :topic_vote do
    vote { 0 }
    topic { create(:topic) }
    user { create(:user) }
  end
end
