require 'rails_helper'

RSpec.describe 'Radio Shows API', type: :request do
  # initialize test data
  let!(:size_radio_show_list) { 1 }

  let!(:user) { create(:dee_jay) }

  let!(:radio_shows) { create_list(:radio_show, size_radio_show_list, dee_jay_id: user.id) }
  let(:radio_show_id) { radio_shows.first.id }
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album) }

  let!(:songs) { create_list(:song, 10, album_id: album.id, artist_id: artist.id) }
   
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/radio_shows
  describe 'GET /api/v1/radio_shows' do
    # make HTTP request before each example
    before { get '/api/v1/radio_shows', params: {}, headers: headers }

    it 'returns radio_shows' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_radio_show_list)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/radio_shows/:id
  describe 'GET /api/v1/radio_shows/:id' do
    before do
      radio_show = radio_shows.first
      songs.each_with_index do |song, i|
        radio_show.tracks.create!( {ordinal: i + 1, song_id: song.id} )
      end
    end

    context 'when the record exists' do
      before do
        get "/api/v1/radio_shows/#{radio_show_id}", params: {}, headers: headers
      end

      it 'returns the radio_show' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(radio_show_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
            
      it 'includes a deejay' do
        expect(json['dee_jay']).not_to be_empty
      end

      it 'includes a tracks array' do
        expect(json['tracks']).not_to be_empty
        expect(json['tracks'].size).to eq(10)
        expect(json['tracks'][0]['song']['album']['title']).to eq(album.title)
        expect(json['tracks'][0]['song']['artist']['name']).to eq(artist.name)
      end
    end

    context 'when the record does not exist' do 
      let(:radio_show_id) {size_radio_show_list + 10}

      before do
        get "/api/v1/radio_shows/#{radio_show_id}", params: {}, headers: headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
