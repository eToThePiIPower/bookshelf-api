require 'rails_helper'

RSpec.describe '/api/v1/books', type: :request do
  context 'when user logged in' do
    let(:user) { create(:user) }
    before do
      login_as(user, cookies: cookies)
    end

    describe 'GET /api/v1/books' do
      before do
        create_list(:book, 2)
        get api_v1_books_path
      end

      it 'returns status code success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'when user not logged in' do
    describe 'GET /api/v1/books' do
      before do
        create_list(:book, 2)
        get api_v1_books_path
      end

      it 'returns status code success' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns message unauthorized' do
        expect(JSON.parse(response.body)['error']).to eq 'Not Authorized'
      end
    end
  end
end
