RSpec.shared_examples 'scoped tests' do
  scenario 'displays the subject name' do
    visit_subject
    expect(page).to have_content(subject.name)
  end

  scenario 'lists topics of the subject only' do
    unreleated_topic = create(:topic)
    visit_collection
    run_expectations_for_topics(topics)
    expect(page).not_to have_content(unreleated_topic.title)
  end
end

RSpec.shared_examples 'listing topics' do

  scenario 'lists latest topics by default' do
    visit_collection
    expect(get_topic_titles).to eq([topics.second.title, topics.first.title])
  end

  scenario 'clicking oldest, lists topics by oldest' do
    visit_collection
    click_link :oldest
    expect(get_topic_titles).to eq([topics.first.title, topics.second.title])
  end

  scenario 'clicking popular, lists topics by popularity' do
    visit_collection

    topics << create(:topic)
    topics.each.with_index(1) do |topic, index|
      topic.vote(topic.creator, :like) if index == 2 || index == 3
      topic.vote(create(:user), :like) if index == 2
    end

    click_link :popular
    expect(get_topic_titles).to eq([topics.second.title, topics.third.title, topics.first.title])
  end

  scenario 'only public topics are listed' do
    private_topic = create(:topic, visibility: :private)
    visit_collection
    run_expectations_for_topics(topics)
    expect(page).not_to have_content(private_topic.title)
  end
end
