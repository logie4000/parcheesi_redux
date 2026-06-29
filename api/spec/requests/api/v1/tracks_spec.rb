require 'rails_helper'

RSpec.describe 'Radio Shows API', type: :request do
  # initialize test data
  SIZE_TRACK_LIST = 10
  let!(:size_track_list) { SIZE_TRACK_LIST }

  let!(:user) { create(:dee_jay) }
  let!(:radio_show) { create(:radio_show, dee_jay_id: user.id) }
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album) }
  
  let!(:songs) { create_list(:song, size_track_list, album_id: album.id, artist_id: artist.id) }

  size_track_list.times do |n| {
    create(:track, ordinal: n, song_id: Song.find(n).id, radio_show_id: radio_show.id)
  }

  let!(:track) { create_list(:track, size_track_list) }
  let(:track_id) { tracks.first.id }
    
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/tracks
  describe 'GET /api/v1/tracks' do
    # make HTTP request before each example
    before { get '/api/v1/tracks', params: {}, headers: headers }

    it 'returns tracks' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_track_list)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/tracks/:id
  describe 'GET /api/v1/tracks/:id' do
    before { get "/api/v1/tracks/#{track_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the track' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(track_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:track_id) {size_track_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
#        expect(response).to match(/Couldn't find/)
#      end
    end
  end
end
