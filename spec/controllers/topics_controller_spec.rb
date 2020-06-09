require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  context 'not signed in' do
    before { get :new}
    it { should respond_with(302)}
  end

  context 'signed in' do
    before do
      user = User.create(email: Faker::Internet.email, password: Devise.friendly_token[0..20])
      sign_in user
      get :new
    end
    it { should respond_with(200)}
  end
end
