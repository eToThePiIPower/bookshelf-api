require 'support/vcr'
require 'services/openlibrary_api'

RSpec.describe OpenlibraryApi do
  let(:client) { OpenlibraryApi.new }
  describe '.lookup' do
    context 'for a new author' do
      it 'returns a book' do
        VCR.use_cassette('openlibrary/lookup_isbn') do
          book = client.lookup_isbn('0451526538')

          expect(book[:isbn]).to eq '0451526538'
          expect(book[:author]).to eq(id: -1, name: 'Mark Twain')
          expect(book[:title]).to eq 'The adventures of Tom Sawyer'
          expect(book[:year]).to eq '1997-01-01'
        end
      end
    end

    context 'for an existing author' do
      it 'returns a book' do
        VCR.use_cassette('openlibrary/lookup_isbn') do
          author = create(:author, name: 'Mark Twain')
          book = client.lookup_isbn('0451526538')

          expect(book[:isbn]).to eq '0451526538'
          expect(book[:author]).to eq(id: author.id, name: 'Mark Twain')
          expect(book[:title]).to eq 'The adventures of Tom Sawyer'
          expect(book[:year]).to eq '1997-01-01'
        end
      end
    end
  end
end
