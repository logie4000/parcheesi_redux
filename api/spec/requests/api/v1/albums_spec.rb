require 'rails_helper'

RSpec.describe 'Albums API', type: :request do
  # initialize test data
  let!(:size_album_list) { 1 }

  let!(:user) { create(:dee_jay) }

  let!(:radio_show) { create(:radio_show, dee_jay_id: user.id) }
  let!(:artist) { create(:artist) }
  let!(:albums) { create_list(:album, size_album_list) }
  let(:album_id) { albums.first.id }
    
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/albums
  describe 'GET /api/v1/albums' do
    # make HTTP request before each example
    before { get '/api/v1/albums', params: {}, headers: headers }

    it 'returns albums' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_album_list)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/albums/:id
  describe 'GET /api/v1/albums/:id' do
    before { get "/api/v1/albums/#{album_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the album' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(album_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:album_id) {size_album_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
#        expect(response).to match(/Couldn't find/)
#      end
    end
  end
end