User.create!(email: 'aurangzaib.danial@gmail.com', password: '5w9u6jGs#iZv')

%w[Game Book].each do |category|
  user = User.create!(email: Faker::Internet.email, password: Devise.friendly_token[0..20])
  3.times do
    title = Faker.const_get(category).unique.title
    Topic.create!(title: title, user: user)
  end
end
