require 'rails_helper'

RSpec.describe 'DeeJays API', type: :request do
  # initialize test data
  let!(:size_dee_jay_list) { 5 }
  let!(:dee_jays) { create_list(:dee_jay, size_dee_jay_list) }
  let(:dee_jay_id) { dee_jays.first.id }
  let!(:radio_show) { create(:radio_show, dee_jay_id: dee_jay_id) }
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album) }

  let!(:songs) { create_list(:song, 10, album_id: album.id, artist_id: artist.id) }

  let!(:user) { dee_jays.first }
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/dee_jays
  describe 'GET /api/v1/dee_jays' do
    # make HTTP request before each example
    before do
      get '/api/v1/dee_jays', params: {}, headers: headers
    end

    it 'returns dee_jays' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_dee_jay_list)
	  
      json.each do |deejay|
        expect(deejay['password_digest']).to be_nil
      end
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/dee_jays/:id
  describe 'GET /api/v1/dee_jays/:id' do
    before do
      songs.each_with_index do |song, i|
        radio_show.tracks.create!( {ordinal: i + 1, song_id: song.id} )
      end
    end

    context 'when the record exists' do
	    before { get "/api/v1/dee_jays/#{dee_jay_id}", params: {}, headers: headers }

      it 'returns the dee_jay' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(dee_jay_id)
		    expect(json['password_digest']).to be_nil
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'includes a radio shows array' do
        expect(json['radio_shows']).not_to be_empty
        expect(json['radio_shows'].size).to eq(1) 
      end

      it 'includes a songs array' do
        expect(json['songs']).not_to be_empty
        expect(json['songs'].size).to eq(10)
        expect(json['songs'][0]['album_id']).to eq(album.id)
        expect(json['songs'][0]['artist_id']).to eq(artist.id)
      end
    end

    context 'when the record does not exist' do
	  before {
	    @dee_jay_id = size_dee_jay_list + 10
	    get "/api/v1/dee_jays/#{@dee_jay_id}", params: {}, headers: headers 
	  }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
