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

    it 'returns the year in YYYY-01-01 format if only the year is known' do
      expect(JSON.parse(response.body)['year']).to eq('1997-01-01')
    end
  end
end
