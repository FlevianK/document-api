require 'rails_helper'

RSpec.describe 'Reviews API' do
  let(:user) { create(:user) }
  let!(:document) { create(:document, created_by: user.id) }
  let!(:reviews) { create_list(:review, 10, document_id: document.id) }
  let(:document_id) { document.id }
  let(:id) { reviews.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /documents/:document_id/reviews
  describe 'GET /documents/:document_id/reviews' do
    before { get "/documents/#{document_id}/reviews", params: {}, headers: headers }

    context 'when document exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all document reviews' do
        expect(json.size).to eq(10)
      end
    end

    context 'when document does not exist' do
      let(:document_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Document/)
      end
    end
  end

  # Test suite for GET /documents/:document_id/reviews/:id
  describe 'GET /documents/:document_id/reviews/:id' do
    before { get "/documents/#{document_id}/reviews/#{id}", params: {}, headers: headers}

    context 'when document review exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the review' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when document review does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  # Test suite for POST /documents/:document_id/reviews
  describe 'POST /documents/:document_id/reviews' do
    let(:valid_attributes) { { comment: 'Visit San Francisco' }.to_json }

    context 'when request attributes are valid' do
      before do
        post "/documents/#{document_id}/reviews", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/documents/#{document_id}/reviews", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Comment can't be blank/)
      end
    end
  end

  # Test suite for PUT /documents/:document_id/reviews/:id
  describe 'PUT /documents/:document_id/reviews/:id' do
    let(:valid_attributes) { { comment: 'Nice place to be' }.to_json }

    before do
      put "/documents/#{document_id}/reviews/#{id}", params: valid_attributes, headers: headers
    end

    context 'when review exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the review' do
        updated_review = Review.find(id)
        expect(updated_review.comment).to match(/Nice place to be/)
      end
    end

    context 'when the review does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Review/)
      end
    end
  end

  # Test suite for DELETE /documents/:id
  describe 'DELETE /documents/:id' do
    before { delete "/documents/#{document_id}/reviews/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end