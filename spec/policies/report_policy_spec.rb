require 'rails_helper'

RSpec.describe ReportPolicy, type: :policy do
  let(:topic) { create(:topic) }
  let(:report) { topic.reports.build }

  context 'topic creator' do
    subject { described_class.new(topic.creator, report) }
    it {should forbid_action(:create)}
  end

  context 'any user other than topic creator' do
    subject { described_class.new(create(:user), report) }
    it {should permit_action(:create)}
  end
end
