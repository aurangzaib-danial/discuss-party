FactoryBot.define do
  factory :topic_tag do
    topic { create(:topic) }
    tag { create(:tag) }
  end
end
