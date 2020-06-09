FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.unique.email }
    password { Devise.friendly_token[0..20] }
  end
end
