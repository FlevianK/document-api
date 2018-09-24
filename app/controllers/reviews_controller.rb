class ReviewsController < ApplicationController
  before_action :set_document
  before_action :set_document_review, only: [:show, :update, :destroy]

  def index
    json_response(@document.reviews)
  end

  def show
    json_response(@review)
  end

  def create
    @document.reviews.create!(review_params)
    json_response(@document, :created)
  end

  def update
    @review.update(review_params)
    head :no_content
  end

  def destroy
    @review.destroy
    head :no_content
  end

  private

  def set_document
    @document = Document.find(params[:document_id])
  end

  def set_document_review
    @review = @document.reviews.find_by!(id: params[:id]) if @document
  end

  def review_params
    params.permit(:comment)
  end
end
