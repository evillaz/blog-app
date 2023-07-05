require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /index' do
    before do
      get '/users'
    end
    it 'return a success response' do
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'gets the correct text placeholder from the body' do
      expect(response.body).to include('Number of posts:')
    end
  end

  describe 'GET /show' do
    before do
      user = User.last
      get "/users/#{user.id}"
    end
    it 'return a success response' do
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template(:show)
    end

    it 'gets the correct text placeholder from the body' do
      expect(response.body).to include('Bio')
    end
  end
end
