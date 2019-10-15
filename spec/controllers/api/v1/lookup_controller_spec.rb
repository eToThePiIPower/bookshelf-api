require 'rails_helper'

RSpec.describe Api::V1::LookupController, type: :controller do
  describe 'GET #lookup_isbn' do
    before do
      VCR.use_cassette('openlibrary/lookup_isbn') do
        get :lookup_isbn, params: { isbn: '0451526538' }
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end
    end
  end
end
