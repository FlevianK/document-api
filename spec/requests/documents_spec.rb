require 'rails_helper'

RSpec.describe 'Documents API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:documents) { create_list(:document, 10, created_by: user.id) }
  let(:document_id) { documents.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /documents
  describe 'GET /documents' do
    # make HTTP get request before each example
    before { get '/documents', params: {}, headers: headers }

    it 'returns documents' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /documents/:id
  describe 'GET /documents/:id' do
    before { get "/documents/#{document_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the document' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(document_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:document_id) { 80 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Document/)
      end
    end
  end

  # Test suite for POST /documents
  describe 'POST /documents' do
    let(:valid_attributes) do
      { title: 'Journey to SF', content: 'One must have a valid passport and VISA', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/documents', params: valid_attributes, headers: headers }

      it 'creates a document' do
        expect(json['title']).to eq('Journey to SF')
        expect(json['content']).to eq('One must have a valid passport and VISA')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/documents', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /documents/:id
  describe 'PUT /documents/:id' do
    let(:valid_attributes) { { title: 'Shopping', content: 'Notebook and a pen' }.to_json }

    context 'when the record exists' do
      before { put "/documents/#{document_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /documents/:id
  describe 'DELETE /documents/:id' do
    before { delete "/documents/#{document_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end