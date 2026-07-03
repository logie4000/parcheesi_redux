require 'rails_helper'

RSpec.describe 'Artists API', type: :request do
  # initialize test data
  let!(:size_artist_list) { 1 }
  let!(:size_album_list) { 10 }

  let!(:user) { create(:dee_jay) }
  let!(:user2) { create(:dee_jay) }

  let!(:artists) { create_list(:artist, size_artist_list) }
  let(:artist_id) { artists.first.id }

  let!(:albums) { create_list(:album, size_album_list) }
  let(:album) { albums.first }
  let(:album_id) { album.id }

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
    
    it 'includes an albums array' do
      expect(json[0]['albums']).not_to be_empty
      expect(json[0]['albums'].size).to eq(1) # All the songs are on the same album
      expect(json[0]['albums'][0]['id']).to eq(album_id)
    end

    it 'includes a songs array' do
      expect(json[0]['songs']).not_to be_empty
      expect(json[0]['songs'].size).to eq(10)
      expect(json[0]['songs'][0]['album_id']).to eq(album_id)
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

      it 'includes a songs array with album info' do
        expect(json['songs']).not_to be_empty
        expect(json['songs'].size).to eq(10)
        expect(json['songs'][0]['album']['title']).to eq(album.title)
      end
    end

    context 'when the record does not exist' do
      let(:artist_id) {size_artist_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /api/v1/top_30' do
    let!(:radio_shows1) { create_list(:radio_show, 30, dee_jay_id: user.id)}
    let!(:radio_shows2) { create_list(:radio_show, 10, dee_jay_id: user2.id)}

    let!(:artists) { create_list(:artist, 40) }
    let!(:songs) { create_list(:song, 40) }
    
    before do
      radio_shows1.each_with_index do |radio_show, idx|
        (idx + 1).times do |n|
          song = artists[n].songs.create!( {title: Faker::Lorem.words(number: 5).join(" ")} )
          radio_show.add_song(song, {ordinal: idx + 1})
        end
      end
      
      radio_shows2.each_with_index do |radio_show, idx|
        (idx + 1).times do |n|
          song = artists[n].songs.create!( {title: Faker::Lorem.words(number: 5).join(" ")} )
          radio_show.add_song(song, {ordinal: idx + 1})
        end
      end
    end

    it 'renders a successful response' do
      get '/api/v1/top_30', headers: headers 
      expect(response).to have_http_status(200)

      get '/api/v1/top_30', params: {dee_jay: user2.id}, headers: headers 
      expect(response).to have_http_status(200)
    end
    
    it 'returns the artists for the given dee jay' do
      get '/api/v1/top_30', params: {dee_jay: user.id}, headers: headers 

      expect(json).not_to be_empty
      expect(json.size).to eq(30)
      
      get '/api/v1/top_30', params: {dee_jay: user2.id}, headers: headers 

      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end
end
