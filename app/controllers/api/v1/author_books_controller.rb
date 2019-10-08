module Api
  module V1
    # AuthorBooksController: Find books by author
    class AuthorBooksController < ApplicationController
      before_action :authorize_access_request!

      def books
        @books = current_user.books.where(author_id: params[:author_id])
      end
    end
  end
end
