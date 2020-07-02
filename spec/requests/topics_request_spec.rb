require 'rails_helper'

RSpec.describe "Topics", type: :request do
  subject { response }
  let(:user) {create(:user)}
  let(:topic) {create(:topic)}

  describe '/topics/new' do
    context 'not signed in' do
      before { get new_topic_path }
      it { should be_redirect }
    end

    context 'signed in' do
      before do
        sign_in user
        get new_topic_path
      end
      it { should be_successful }
    end
  end

  describe 'PATCH /topics/:id/vote should redirect_to the request referer' do
    it 'when referer is root_path' do
      sign_in user
      patch vote_topic_path(topic), params: {vote: 'like'}, headers: { 'HTTP_REFERER' => 'http://example.com/' }
      expect(subject).to redirect_to('http://example.com/')
    end

    it 'when referer is a topic permalink' do
      the_origin = 'http://example.com' + topic_slug_path(topic.id, topic.slug)
      sign_in user
      patch vote_topic_path(topic), params: {vote: 'like'}, 
        headers: { 'HTTP_REFERER' => the_origin }
      expect(subject).to redirect_to(the_origin)
    end
  end

  describe 'edit/update' do
    let(:random_user) {create(:user)} 
    let(:edit_path) {edit_topic_path(topic.id, topic.slug)}
    let(:update_path) {topic_path(topic.id)}
    
    context 'topic creator' do
      before do
        sign_in topic.creator
      end
      it 'permit edit' do
        get edit_path
        expect(response).to be_successful
      end

      it 'permit update' do
        patch update_path, params: { topic: {title: 'updating the post'} } 
        follow_redirect!
        expect(response).to be_successful
      end
    end

    context 'random user' do
      before do
        sign_in random_user
      end
      it 'forbid edit' do
        get edit_path
        expect(response).to be_forbidden
      end
      it 'forbid update' do
        patch update_path, params: { topic: {title: 'updating the post'} } 
        expect(response).to be_forbidden
      end
    end
  end
end
