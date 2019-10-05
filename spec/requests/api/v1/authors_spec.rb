require 'rails_helper'

RSpec.describe '/api/v1/authors', type: :request do
  describe 'GET /api/v1/authors' do
    before do
      create_list(:author, 2)
      get api_v1_authors_path, as: :json
    end

    it 'returns all of the authors' do
      expect(JSON.parse(response.body).size).to eq 2
    end

    it 'returns status code success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/author/#' do
    before do
      author = create(:author, name: 'Author McAuthorface')
      get api_v1_author_path(author), as: :json
    end

    it 'includes the author name' do
      expect(JSON.parse(response.body)['name']).to eq 'Author McAuthorface'
    end

    it 'returns status code success' do
      expect(response).to have_http_status(:success)
    end
  end
end
