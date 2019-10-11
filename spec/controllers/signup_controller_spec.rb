require 'rails_helper'

RSpec.describe SignupController, type: :controller do
  describe 'GET #create' do
    context 'with valid params' do
      before do
        params = {
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
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

    context 'when email is blank' do
      before do
        params = {
          email: '',
          password: 'password',
          password_confirmation: 'password'
        }

        get :create, params: params
      end

      it 'returns http success' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not returns the csrf in the json response' do
        expect(JSON.parse(response.body)).not_to have_key('csrf')
        expect(JSON.parse(response.body)['error']['email']).to include "can't be blank"
      end

      it 'does not returns a jwt_access key in the response cookie' do
        expect(response.cookies).not_to have_key('jwt_access')
      end
    end
  end
end
