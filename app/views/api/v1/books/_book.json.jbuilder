json.extract! book, :id, :title, :year, :isbn, :created_at, :updated_at
json.author do
  json.extract! book.author, :name, :id
  json.url api_v1_author_url(book.author, format: :json)
end
json.url api_v1_book_url(book, format: :json)
