json.extract! book, :id, :title, :year, :isbn, :author_id, :user_id, :created_at, :updated_at
json.url api_v1_book_url(book, format: :json)
