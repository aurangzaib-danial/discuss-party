%w[Game Book].each do |category|
  3.times do
    title = Faker.const_get(category).unique.title
    Topic.create(title: title)
  end
end
