FactoryBot.define do
  factory(:topic) do
    title { 'This is a superb topic for discussion'}
    description { Faker::Lorem.paragraph }
    user { build(:user) }
    tags { [build(:tag), build(:tag)]}
  end
end
