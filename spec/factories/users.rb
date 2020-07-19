FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.unique.email }
    password { Devise.friendly_token[0..20] }
    name { Faker::Name.name }
    before(:create) do |user|
      user.skip_confirmation!
    end
  end
end
