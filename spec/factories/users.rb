FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.unique.email }
    password { Devise.friendly_token[0..20] }
    name { 'avi flombaum' }
  end
end
