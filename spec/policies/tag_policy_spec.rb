require 'rails_helper'

RSpec.describe TagPolicy, type: :policy do
  subject { described_class.new(user, tag) }
  
  let(:tag) { create(:tag) }
  let(:moderator_actions) { %i[new create update index edit]}
  let(:admin_actions) {moderator_actions.push(:destroy)}

  context 'normal_user' do
    let(:user) { create(:user) }
    it {should forbid_actions(admin_actions)}
  end

  context 'moderator' do
    let(:user) {create(:user, role: 'moderator')}
    it {should permit_actions(moderator_actions)}
    it {should forbid_action(:destroy)}
  end

  context 'admin' do
    let(:user) {create(:user, role: 'admin')}
    it {should permit_actions(admin_actions)}
  end
end
