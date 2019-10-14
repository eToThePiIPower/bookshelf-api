require 'rails_helper'

RSpec.describe '/api/v1/lookup_isbn', type: :request do
  describe 'GET /api/v1/lookup_isbn' do
    before do
      VCR.use_cassette('openlibrary/lookup_isbn') do
        get '/api/v1/lookup_isbn/0451526538', as: :json
      end
    end

    it 'returns the author with an id of -1' do
      expect(JSON.parse(response.body)['author']).to eq('id' => -1, 'name' => 'Mark Twain')
    end
  end
end
