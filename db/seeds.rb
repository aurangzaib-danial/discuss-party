User.create!(email: 'aurangzaib.danial@gmail.com', password: '5w9u6jGs#iZv', name: 'Aurangzaib Danial')

tags = Tag.create!([{name: 'appliances'}, {name: 'reading'}])
other_tag = Tag.create(name: 'interesting')
%w[Game Book].each.with_index do |category, index|
  user = User.create!(email: Faker::Internet.email, password: Devise.friendly_token[0..20], name: Faker::Name.name)
 
  3.times do
    title = Faker.const_get(category).unique.title
    description = Faker::Lorem.paragraph(sentence_count: 20)
    topic = Topic.new(title: title, user: user, description: description)
    topic.topic_tags.build(tag: tags[index])
    topic.topic_tags.build(tag: other_tag)
    topic.save!
  end

end
