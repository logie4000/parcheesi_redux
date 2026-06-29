require 'rails_helper'

RSpec.describe 'Artists API', type: :request do
  # initialize test data
  let!(:size_artist_list) { 1 }

  let!(:user) { create(:dee_jay) }

  let!(:artists) { create_list(:artist, size_artist_list) }
  let(:artist_id) { artists.first.id }
    
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/artists
  describe 'GET /api/v1/artists' do
    # make HTTP request before each example
    before { get '/api/v1/artists', params: {}, headers: headers }

    it 'returns artists' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_artist_list)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/artists/:id
  describe 'GET /api/v1/artists/:id' do
    before { get "/api/v1/artists/#{artist_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the artist' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(artist_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:artist_id) {size_artist_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
#        expect(response).to match(/Couldn't find/)
#      end
    end
  end
end
