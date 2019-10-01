require 'rails_helper'

RSpec.describe SigninController, type: :controller do
  describe 'GET #create' do
    let(:user) { create(:user, password: 'password') }

    context 'with valid credentials' do
      before do
        params = {
          email: user.email,
          password: 'password'
        }

        get :create, params: params
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the csrf in the json response' do
        expect(JSON.parse(response.body)).to have_key('csrf')
      end

      it 'returns a jwt_access key in the response cookie' do
        expect(response.cookies).to have_key('jwt_access')
      end
    end

    context 'with invalid credentials' do
      before do
        params = {
          email: user.email,
          password: 'NOT THE PASSWORD'
        }

        get :create, params: params
      end

      it 'returns http success' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does not returns the csrf in the json response' do
        expect(JSON.parse(response.body)).not_to have_key('csrf')
        expect(JSON.parse(response.body)['error']).to eq 'Email or password are invalid'
      end
    end
  end
end
