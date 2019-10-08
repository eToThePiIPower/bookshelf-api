require 'rails_helper'

RSpec.describe Api::V1::AuthorBooksController, type: :controller do
  let(:user) { create(:user) }
  let(:author) { create(:author) }
  before do
    3.times { create(:book, user: user, author: author) }
  end

  context 'when not logged in' do
    describe 'GET #books' do
      it 'returns an unauthorized response' do
        get :books, params: { author_id: author.id }, as: :json
        expect(response).to be_unauthorized
      end
    end
  end

  context 'when logged in' do
    before do
      login_as(user, request: request)
    end

    describe 'GET #books' do
      it 'returns http success' do
        get :books, params: { author_id: author.id }, as: :json
        expect(response).to have_http_status(:success)
      end
    end
  end
end
