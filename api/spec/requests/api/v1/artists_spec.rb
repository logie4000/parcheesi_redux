require 'rails_helper'

RSpec.describe 'Artists API', type: :request do
  # initialize test data
  let!(:size_artist_list) { 1 }
  let!(:size_album_list) { 10 }

  let!(:user) { create(:dee_jay) }

  let!(:artists) { create_list(:artist, size_artist_list) }
  let(:artist_id) { artists.first.id }

  let!(:albums) { create_list(:album, size_album_list) }
  let(:album_id) { albums.first.id }

  let!(:songs) { create_list(:song, 10, album_id: albums.first.id, artist_id: artists.first.id) }
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

      it 'includes an albums array' do
        expect(json['albums']).not_to be_empty
        expect(json['albums'].size).to eq(1) # All the songs are on the same album
      end

      it 'includes a songs array' do
        expect(json['songs']).not_to be_empty
        expect(json['songs'].size).to eq(10)
        expect(json['songs'][0]['album']).not_to be_nil
        expect(json['songs'][0]['album']['id']).to eq(album_id)
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
