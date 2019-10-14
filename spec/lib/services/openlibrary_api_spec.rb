require 'support/vcr'
require 'services/openlibrary_api'

RSpec.describe OpenlibraryApi do
  let(:client) { OpenlibraryApi.new }
  describe '.lookup' do
    it 'returns a book' do
      VCR.use_cassette('openlibrary/lookup_isbn') do
        book = client.lookup_isbn('0451526538')

        expect(book[:isbn10]).to eq '0451526538'
        expect(book[:authors]).to eq ['Mark Twain']
        expect(book[:title]).to eq 'The adventures of Tom Sawyer'
        expect(book[:year]).to eq '1997'
      end
    end
  end
end
