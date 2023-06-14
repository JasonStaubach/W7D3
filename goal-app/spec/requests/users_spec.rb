require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'new user' do
    it 'renders the new user form' do
      get new_user_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('New User')
    end
  end

  describe 'make user' do
    it 'creates a new user' do
      post users_path, params: { user: { username: 'jeffrey', password: 'password' } }
      expect(response).to redirect_to(new_user_url)
      expect(User.last.username).to eq('jeffrey')
    end
  end

  describe 'redirects to login' do
    it 'renders the login form' do
      get login_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Login')
    end
  end

  describe 'login' do
    it 'logs in the user' do
      user = User.create(username: 'jeffrey', password: 'password')
      post login_path, params: { session: { username: 'jeffrey', password: 'password' } }
      expect(response).to redirect_to(user_url)
      expect(session[:user_id]).to eq(user.id)
    end
  end


end
