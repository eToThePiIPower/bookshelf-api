require 'rails_helper'

RSpec.describe '/api/v1/authors/:id/books', type: :request do
  let(:author) { create(:author) }
  let(:user) { create(:user) }
  before do
    create_list(:book, 8, user: user, author: author)
    create_list(:book, 4, user: user) # not by author
    create_list(:book, 2) # not by user nor author
  end

  context 'when logged in' do
    before do
      login_as(user, cookies: cookies)
    end

    describe 'GET /api/v1/authors/:id/books' do
      before do
        get api_v1_author_books_path(author.id), as: :json
      end

      it "returns all of the author's books" do
        expect(JSON.parse(response.body).size).to eq 8
      end
    end
  end
end
