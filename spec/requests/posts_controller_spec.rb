require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let(:user) { User.first }
  let!(:post) { user.posts.create(title: 'first post') }
  describe 'GET /index' do
    before do
      get "/users/#{user.id}/posts"
    end
    it 'return a success response' do
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'gets the correct text placeholder from the body' do
      expect(response.body).to include('Post')
    end
  end

  describe 'GET /show' do
    before do
      get "/users/#{user.id}/posts/#{post.id}"
    end
    it 'return a success response' do
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template(:show)
    end

    it 'gets the correct text placeholder from the body' do
      expect(response.body).to include('Comment')
    end
  end
end
