require 'rails_helper'

RSpec.describe Report, type: :model do
  it {should belong_to(:user)}
  it {should belong_to(:topic)}
  it {should have_db_index([:user_id, :topic_id]).unique}
  it {should have_db_column(:report_type).of_type(:integer).with_options(null: false)}
  it do
    should define_enum_for(:report_type).
      with_values(
        rude: 0,
        harassment: 1,
        spam: 2,
        copyright: 3
      )
  end
end
