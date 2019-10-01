require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      create_list(:author, 2)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      author = create(:author)
      get :show, params: { id: author.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Author' do
        expect do
          post :create, params: { author: attributes_for(:author) }
        end.to change(Author, :count).by(1)
      end

      it 'renders a JSON response with the new author' do
        post :create, params: { author: attributes_for(:author) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(api_v1_author_url(Author.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new author' do
        post :create, params: { author: attributes_for(:author, name: '') }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested author' do
        author = create(:author, name: 'Old Name')
        put :update, params: { id: author.to_param, author: { name: 'New Name' } }
        author.reload
        expect(author.name).to eq('New Name')
      end

      it 'renders a JSON response with the author' do
        author = create(:author, name: 'Old Name')

        put :update, params: { id: author.to_param, author: { name: 'New Name' } }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the author' do
        author = create(:author)

        put :update, params: { id: author.to_param, author: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested author' do
      author = create(:author)
      expect do
        delete :destroy, params: { id: author.to_param }
      end.to change(Author, :count).by(-1)
    end
  end
end
