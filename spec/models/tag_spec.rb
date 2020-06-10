require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_db_column(:name) }
  it { should have_many(:topic_tags) }
  it { should have_many(:topics).through(:topic_tags) }
  # have a name present
  # only contains letters and hypens
  # strips multiple hypens and on start and end
  # min 3, max 30
  # it { should }
end
