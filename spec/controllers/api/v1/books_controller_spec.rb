require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      create(:book)
      get :index, params: {}, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      book = create(:book)
      get :show, params: { id: book.to_param }, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Book' do
        expect do
          post :create, params: { book: nested_attributes_for(:book) }, as: :json
        end.to change(Book, :count).by(1)
      end

      it 'renders a JSON response with the new book' do
        post :create, params: { book: nested_attributes_for(:book) }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(api_v1_book_url(Book.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new book' do
        post :create, params: { book: nested_attributes_for(:book, title: '') }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested book' do
        book = create(:book)
        put :update, params: { id: book.to_param, book: { title: 'New Title' } }, as: :json
        book.reload
        expect(book.title).to eq 'New Title'
      end

      it 'renders a JSON response with the book' do
        book = create(:book)

        put :update, params: { id: book.to_param, book: attributes_for(:book) }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the book' do
        book = create(:book)

        put :update, params: { id: book.to_param, book: { title: '' } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested book' do
      book = create(:book)
      expect do
        delete :destroy, params: { id: book.to_param }, as: :json
      end.to change(Book, :count).by(-1)
    end
  end
end
