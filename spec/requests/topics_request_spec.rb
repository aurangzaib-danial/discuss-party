require 'rails_helper'

RSpec.describe "Topics", type: :request do
  subject { response }
  describe '/topics/new' do
    context 'not signed in' do
      before { get new_topic_path }
      it { should be_redirect }
    end

    context 'signed in' do
      before do
        user = create(:user)
        sign_in user
        get new_topic_path
      end
      it { should be_successful }
    end
  end
end
