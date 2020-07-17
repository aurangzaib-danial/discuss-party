require 'rails_helper'

RSpec.describe ReportPolicy, type: :policy do
  let(:topic) { create(:topic) }

  context 'topic creator' do
    subject { described_class.new(topic.creator, Report.new) }
    it {should forbid_action(:create, topic)}
  end

  context 'any user other than topic creator' do
    subject { described_class.new(create(:user), Report.new) }
    it {should permit_action(:create, topic)}
  end
end
