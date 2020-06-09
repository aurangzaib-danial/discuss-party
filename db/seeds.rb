User.create!(email: 'aurangzaib.danial@gmail.com', password: '5w9u6jGs#iZv')

tags = Tag.create!([{name: 'games'}, {name: 'reading'}])
other_tag = Tag.create(name: 'interesting')
%w[Game Book].each.with_index do |category, index|
  user = User.create!(email: Faker::Internet.email, password: Devise.friendly_token[0..20])
  3.times do
    title = Faker.const_get(category).unique.title
    description = Faker::Lorem.paragraph(sentence_count: 10)
    topic = Topic.create!(title: title, user: user, description: description)
    TopicTag.create!(topic: topic, tag: tags[index])
    TopicTag.create!(topic: topic, tag: other_tag)
  end
end
