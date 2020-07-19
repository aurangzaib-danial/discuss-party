FactoryBot.define do
  factory(:topic) do
    sequence(:title) { |n| "The topic is #{n}" }
    description { Faker::Lorem.paragraph }
    creator do 
      build(:user).tap {|user| user.skip_confirmation! }
    end
  end
end
