module Api
  module V1
    # AuthorsController: Controller for Authors
    class AuthorsController < ApplicationController
      before_action :set_author, only: [:show, :update, :destroy]
      before_action :set_default_format

      # GET /api/v1/authors
      # GET /api/v1/authors.json
      def index
        @authors = Author.all
      end

      # GET /api/v1/authors/1
      # GET /api/v1/authors/1.json
      def show; end

      # POST /api/v1/authors
      # POST /api/v1/authors.json
      def create
        @author = Author.new(author_params)

        if @author.save
          render :show, status: :created, location: api_v1_author_url(@author)
        else
          render json: @author.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/authors/1
      # PATCH/PUT /api/v1/authors/1.json
      def update
        if @author.update(author_params)
          render :show, status: :ok, location: api_v1_author_url(@author)
        else
          render json: @author.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/authors/1
      # DELETE /api/v1/authors/1.json
      def destroy
        @author.destroy
      end

      private

      def set_author
        @author = Author.find(params[:id])
      end

      def author_params
        params.fetch(:author, {}).permit(:name)
      end

      def set_default_format
        request.format = :json
      end
    end
  end
end
