RSpec.describe Topic, type: :model do
  it { should have_db_column(:title) }
  it { should have_db_column(:description) }
  
end
