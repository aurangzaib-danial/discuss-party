RSpec.describe User, type: :model do
  it { should have_many(:topics) }
end
