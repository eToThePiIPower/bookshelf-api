require "#{Rails.root}/lib/services/openlibrary_api"

module Api
  module V1
    # LookupController
    class LookupController < ApplicationController
      def isbn
        client = OpenlibraryApi.new
        book = client.lookup_isbn(params[:isbn])
        render json: book
      end
    end
  end
end
