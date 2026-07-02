require 'rails_helper'

RSpec.describe 'Tracks API', type: :request do
  # initialize test data
  SIZE_TRACK_LIST = 10
  let!(:size_track_list) { SIZE_TRACK_LIST }

  let!(:user) { create(:dee_jay) }
  let!(:radio_show) { create(:radio_show, dee_jay_id: user.id) }
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album) }
  
  let!(:songs) { create_list(:song, SIZE_TRACK_LIST, album_id: album.id, artist_id: artist.id) }
  let!(:song_1) { songs.first }

  let!(:tracks) { create_list(:track, SIZE_TRACK_LIST, song_id: song_1.id, radio_show_id: radio_show.id) }

  let(:track) { tracks.first }
  let(:track_id) { track.id }
    
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

    it 'includes a song with artist and album' do
      expect(json[0]['song']).not_to be_empty
      expect(json[0]['song']['id']).to eq(track.song.id)
      expect(json[0]['song']['album']['title']).to eq(track.song.album.title)
      expect(json[0]['song']['artist']['name']).to eq(track.song.artist.name)
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
       
      it 'includes a song with artist and album' do
        expect(json['song']).not_to be_empty
        expect(json['song']['id']).to eq(track.song.id)
        expect(json['song']['album']['title']).to eq(track.song.album.title)
        expect(json['song']['artist']['name']).to eq(track.song.artist.name)
      end
    end

    context 'when the record does not exist' do
      let(:track_id) {size_track_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
