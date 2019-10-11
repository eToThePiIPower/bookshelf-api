require 'rails_helper'

RSpec.describe RefreshController, type: :controller do
  let!(:user) { create(:user) }

  context 'when logged in' do
    before do
      JWTSessions.access_exp_time = 0
      login_as(user, request: request)
      JWTSessions.access_exp_time = 3600
    end

    it 'is successful' do
      post :create
      expect(response).to be_successful
    end

    it 'returns a new csrf token' do
      post :create
      expect(JSON.parse(response.body)).to include('csrf')
      expect(JSON.parse(response.body)['csrf']).not_to eq request.headers['X-CSRF-TOKEN']
    end

    it 'generates a new jwt_access token as a cookie' do
      post :create
      expect(response.cookies).to include('jwt_access')
      expect(response.cookies['jwt_access']).not_to eq request.cookies['jwt_access']
    end
  end
end
