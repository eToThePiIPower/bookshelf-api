module Api
  module V1
    # AuthorsController: Controller for Authors
    class AuthorsController < ApplicationController
      before_action :authorize_access_request!, only: [:create, :update, :destroy]
      before_action :set_author, only: [:show, :update, :destroy]

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
          render json: { error: @author.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/authors/1
      # PATCH/PUT /api/v1/authors/1.json
      def update
        if @author.update(author_params)
          render :show, status: :ok, location: api_v1_author_url(@author)
        else
          render json: { error: @author.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/authors/1
      # DELETE /api/v1/authors/1.json
      def destroy
        @author.destroy
      rescue ActiveRecord::InvalidForeignKey
        render json: {
          error: 'Cannot delete Author with dependents'
        }, status: :unprocessable_entity
      end

      private

      def set_author
        @author = Author.find(params[:id])
      end

      def author_params
        params.fetch(:author, {}).permit(:name)
      end
    end
  end
end
