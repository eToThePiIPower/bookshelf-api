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
      isbn: extract_isbn(data['identifiers']),
      title: data['title'],
      author: find_author(data['authors'].first['name']),
      year: data['publish_date']
    }
  end

  def extract_isbn(identifiers)
    isbn10 = identifiers['isbn_10']
    isbn13 = identifiers['isbn_13']
    isbn13.is_a?(Array) ? isbn13.first : isbn10.first
  end

  def find_author(name)
    author = Author.find_by(name: name)
    if author
      { id: author.id, name: author.name }
    else
      { id: -1, name: name }
    end
  end
end
