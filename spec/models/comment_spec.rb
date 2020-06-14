require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_db_column(:content) }
  it { should belong_to(:topic) }
  it { should belong_to(:user) }
end
