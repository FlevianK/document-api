class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :update, :destroy]

  def index
    @documents = current_user.documents.paginate(page: params[:page], per_page: 10)
    json_response(@documents)
  end

  def show
    json_response(@document)
  end

  def create
    @document = current_user.documents.create!(document_params)
    json_response(@document, :created)
  end

  def update
    @document.update(document_params)
    head :no_content
  end

  def destroy
    @document.destroy
    head :no_content
  end

  private

  def document_params
    params.require(:document).permit(:title, :content)
  end

  def set_document
    @document = Document.find(params[:id])
  end
end
