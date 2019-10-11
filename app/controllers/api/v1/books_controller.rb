module Api
  module V1
    # BooksController:
    class BooksController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_book, only: [:show, :update, :destroy]

      # GET /books
      # GET /books.json
      def index
        @books = current_user.books.all
      end

      # GET /books/1
      # GET /books/1.json
      def show; end

      # POST /books
      # POST /books.json
      def create
        @book = current_user.books.new(book_params)

        if @book.save
          render :show, status: :created, location: api_v1_book_url(@book)
        else
          render json: { error: @book.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /books/1
      # PATCH/PUT /books/1.json
      def update
        if @book.update(book_params)
          render :show, status: :ok, location: api_v1_book_url(@book)
        else
          render json: { error: @book.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /books/1
      # DELETE /books/1.json
      def destroy
        @book.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_book
        @book = current_user.books.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Book not found' }, status: :unprocessable_entity
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def book_params
        params.require(:book).permit(:title, :year, :isbn, :author_id)
      end
    end
  end
end
