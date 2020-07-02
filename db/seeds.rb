sunny = User.create!(email: 'aurangzaib.danial@gmail.com', password: '5w9u6jGs#iZv', name: 'Aurangzaib Danial')
avi = User.create!(email: 'avi@fs.com', password: 'khan1234', name: 'Avi Flombaum')


tags = Tag.create!([{name: 'games'}, {name: 'reading'}])
other_tag = Tag.create(name: 'interesting')
%w[Game Book].each.with_index do |category, index|
  user = User.create!(email: Faker::Internet.email, password: Devise.friendly_token[0..20], name: Faker::Name.name)
 
  3.times do
    title = Faker.const_get(category).unique.title
    description = Faker::Lorem.paragraph(sentence_count: 20)
    topic = Topic.new(title: title, creator: user, description: description)
    topic.topic_tags.build(tag: tags[index])
    topic.topic_tags.build(tag: other_tag)
    topic.save!
    topic.vote(user, :like)
  end

end

second = Topic.second
second.vote(sunny, :like)
second.vote(avi, :like)
second.vote(User.last, :dislike)

third = Topic.fourth
third.vote(avi, :like)
