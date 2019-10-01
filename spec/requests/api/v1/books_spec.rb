require 'rails_helper'

RSpec.describe '/api/v1/books', type: :request do
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
