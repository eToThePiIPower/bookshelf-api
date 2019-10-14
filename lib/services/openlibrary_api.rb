require 'net/http'
require 'json'

# Openlibrary API
class OpenlibraryApi
  URL_BASE = 'https://openlibrary.org/api/books?format=json&jscmd=data&bibkeys=ISBN:'.freeze

  def lookup_isbn(isbn)
    uri = URI(URL_BASE + isbn)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)
    data = json["ISBN:#{isbn}"]
    extract_book(data)
  end

  private

  def extract_book(data)
    {
      isbn10: extract_isbn(data['identifiers']['isbn_10']),
      isbn: extract_isbn(data['identifiers']['isbn_13']),
      authors: data['authors'].map { |a| a['name'] },
      title: data['title'],
      year: data['publish_date']
    }
  end

  def extract_isbn(isbn_array)
    isbn_array.is_a?(Array) ? isbn_array.first : isbn_array
  end
end
