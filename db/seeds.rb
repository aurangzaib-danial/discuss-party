sunny = User.create!(email: 'aurangzaib.danial@gmail.com', password: 'khan1234', name: 'Aurangzaib Danial Liaqat Khan')
avi = User.create!(email: 'avi@fs.com', password: 'avi1234', name: 'Avi Flombaum')
adam = User.create!(email: 'adam@comedy.com', password: 'adam1234', name: 'Adam Weissman')
random_user = User.create!(email: Faker::Internet.unique.email, password: 'random1234', name: Faker::Name.unique.name)

@users = [sunny, avi, adam]

tags = Tag.create!(
  [
    {name: 'games'}, 
    {name: 'reading'}, 
    {name: 'interesting'}, 
    {name: 'politics'}
  ]
)

def faker_topic(topic_type, creator, visibility, *tags)
  topic = Topic.create!(
    title: Faker::const_get(topic_type).unique.title, 
    description: Faker::Lorem.paragraph(sentence_count: 20), 
    creator: creator,
    visibility: visibility,
    tags: tags
  )

  topic.vote(@users.sample, :like)
  topic
end

sunny_topic = faker_topic('Game', sunny, :public, tags.first, tags.third)
sunny_topic.vote(random_user, :like)

faker_topic('Book', sunny, :private, tags.second, tags.last)

faker_topic('Game', adam, :public, tags.second, tags.last)
adam_topic = faker_topic('Book', adam, :private, tags.second, tags.third, tags.last)
adam_topic.private_viewers << sunny

faker_topic('Game', avi, :public, tags.first, tags.third)
avi_topic = faker_topic('Book', avi, :public, tags.last)
avi_topic.private_viewers << sunny

faker_topic('Book', random_user, :public, tags.second, tags.third, tags.last)


some_users = [FactoryBot.create(:user), FactoryBot.create(:user), FactoryBot.create(:user)]

50.times do
  Topic.new.tap do |t|
    t.title = Faker::Book.title
    t.description = Faker::Lorem.paragraph(sentence_count: 15)
    t.tags = [tags.sample]
    t.creator = some_users.sample
    t.save!
  end
end
