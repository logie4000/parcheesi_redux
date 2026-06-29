require 'rails_helper'

RSpec.describe 'Songs API', type: :request do
  # initialize test data
  let!(:size_song_list) { 1 }

  let!(:user) { create(:dee_jay) }

  let!(:radio_show) { create(:radio_show, dee_jay_id: user.id) }
  let!(:artist) { create(:artist) }
  let!(:album) { create(:album) }
  let!(:songs) { create_list(:song, size_song_list, album_id: album.id, artist_id: artist.id) }
  let(:song_id) { songs.first.id }
    
  let(:headers) { valid_headers }

  # Test suite for GET /api/v1/songs
  describe 'GET /api/v1/songs' do
    # make HTTP request before each example
    before { get '/api/v1/songs', params: {}, headers: headers }

    it 'returns songs' do
      # Note that 'json' is a custom helper
      expect(json).not_to be_empty
      expect(json.size).to eq(size_song_list)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/v1/songs/:id
  describe 'GET /api/v1/songs/:id' do
    before { get "/api/v1/songs/#{song_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the song' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(song_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:song_id) {size_song_list + 10}
 
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

#      it 'returns a not found message' do
#        expect(response).to match(/Couldn't find/)
#      end
    end
  end

  # Test suite for POST /api/v1/songs
  describe 'POST /api/v1/songs' do
    context 'when the request is valid for a new song' do
      before do
        @post_params = { song: { publish_date: "2020-08-18",
                         title: "Oceansize",
                         artist_name: "Jane's Addiction",
                         album_title: "Nothing's Shocking",
                         dee_jay_id: user.id,
                  #       track_ordinal: 1,
                       },
                         commit: "Create" } 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'creates a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params.to_json, headers: headers }.to change{  RadioShow.all.count }.by(1)
      end
      
      it 'creates a Track' do
        expect{ post "/api/v1/songs", params: @post_params.to_json, headers: headers }.to change{ Track.all.count }.by(1)
      end
      
      it 'creates an Artist' do
        expect{ post "/api/v1/songs", params: @post_params.to_json, headers: headers }.to change{ Artist.all.count }.by(1)
      end
      
      it 'creates a Album' do
        expect{ post "/api/v1/songs", params: @post_params.to_json, headers: headers }.to change{ Album.all.count }.by(1)
      end
      
      it 'creates a Song' do
        expect{ post "/api/v1/songs", params: @post_params.to_json, headers: headers }.to change{ Song.all.count }.by(1)
      end

      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @artist = Artist.all.last
        @album = Album.all.last
        @song = Song.all.last        
        @track = Track.all.last
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params.to_json, headers: headers 
        
      #  expect(json).to eq("something")
        expect(json["title"]).to eq("Oceansize")
      end
    end

    context 'when the request is valid for an existing artist' do
      before do
        @album = Album.all.last
        @artist = @album.artists.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: "Oceansize",
                          artist_id: @artist.id,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                 #         track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        @post_params2 = { song: { publish_date: "2020-08-18",
                          title: "Jane Says",
                          artist_id: @artist.id,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                 #         track_ordinal: 2,
                        },
                         commit: "Create" } 
                         
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does not create an Artist' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Artist.all.count }
      end
      
      it 'creates a Song' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Song.all.count }.by(1)
      end
      
      it 'does not create a Album' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ RadioShow.all.count }
      end

      it 'creates a Track' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Track.all.count }.by(1)
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @song = Song.all.last
        @track = Track.all.last
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq("Jane Says")
      end
    end
       
    context 'when the request is valid for a new radio show playing an new artist with a duplicate album title' do
      before do
        @album = Album.all.last
        @artist = @album.artists.first
        @song = @album.songs.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        @post_params2 = { song: { publish_date: "2020-09-01",
                          title: @song.title,
                          artist_name: "The Small Hours Reunion Tour",
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 2,
                        },
                         commit: "Create" }
                         
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does create an Artist' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Artist.all.count }.by(1)
      end
      
      it 'does create a Song' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Song.all.count }.by(1)
      end
      
      it 'does create a Album' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Album.all.count }.by(1)
      end

      it 'does create a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ RadioShow.all.count }.by(1)
      end

      it 'does create a Track' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Track.all.count }.by(1)
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers
        @new_artist = Artist.last
        @radio_show = RadioShow.all.last
        @track = Track.all.last
        @new_song = Song.last
        @new_album = Album.last
        
        # Song.artist should point to Artist
        expect(@new_song.artist).to eq(@new_artist)
        
        # Song.album should point to Album
        expect(@new_song.album).to eq(@new_album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@new_song)
        
        # Album.songs should contain Song
        expect(@new_album.songs).to include(@new_song)
        
        # Artist.albums should contain Album
        expect(@new_artist.albums).to include(@new_album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)        
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq( @song.title )
      end
    end
    
    context 'when the request is valid for a new radio show playing an existing artist, album, song combo' do
      before do
        @album = Album.all.last
        @artist = @album.artists.first
        @song = @album.songs.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        @post_params2 = { song: { publish_date: "2020-09-01",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 2,
                        },
                         commit: "Create" } 
                         
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does not create an Artist' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Artist.all.count }
      end
      
      it 'does not create a Song' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Song.all.count }
      end
      
      it 'does not create a Album' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a Album even when there is extra whitespace in the album title' do
        expect{ post "/api/v1/songs", params: @post_params3.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does create a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ RadioShow.all.count }.by(1)
      end

      it 'does create a Track' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Track.all.count }.by(1)
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @track = Track.all.last
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)        
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq( @song.title )
      end
    end
    
    context 'when the request is valid for an existing artist, album, song combo' do
      before do
        @album = Album.all.last
        @artist = @album.artists.first
        @song = @album.songs.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        @post_params2 = { song: { publish_date: "2020-09-01",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 2,
                        },
                         commit: "Create" } 
                         
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does not create an Artist (case insensitive)' do
        @post_params2 = { song: { publish_date: "2020-09-01",
                          title: @song.title,
                          artist_name: @artist.name.upcase,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 2,
                        },
                         commit: "Create" } 
                          
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Artist.all.count }
      end
      
      it 'does not create a Song (case insensitive)' do
        @post_params2 = { song: { publish_date: "2020-09-01",
                          title: @song.title.upcase,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: 2,
                        },
                         commit: "Create" } 
                          
      expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Song.all.count }
      end
      
      it 'does not create a Album (case insentive)' do
        @post_params2 = { song: { publish_date: "2020-09-01",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title.upcase,
                          dee_jay_id: user.id,
                  #        track_ordinal: 2,
                        },
                         commit: "Create" } 
                          
      expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does create a RadioShow (case insentive)' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ RadioShow.all.count }.by(1)
      end

      it 'does create a Track (case insentive)' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.to change{ Track.all.count }.by(1)
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @track = Track.all.last
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)        
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq( @song.title )
      end
    end
    
    context 'when the request is valid double post for an existing artist, album, song combo' do
      before do
        @album = Album.all.last
        @artist = @album.artists.first
        @song = @album.songs.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                   #       track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does not create an Artist' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Artist.all.count }
      end
      
      it 'does not create a Song' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Song.all.count }
      end
      
      it 'does not create a Album' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ RadioShow.all.count }
      end

      it 'does not create a Track' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Track.all.count }
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @track = Track.all.last
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)        
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq( @song.title )
      end
      
      it 'sets the track ordinal to the last value for the radio_show track list' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        
        @radio_show = RadioShow.all.last
        @track = Track.all.last
        
#        expect(json).to eq("something")
        @track = Track.all.last
        expect(@track.ordinal).to eq( @radio_show.tracks.count )
      end
    end

    context 'when the request is valid double post for an existing artist, album, song combo and the song is orphaned' do
      before do
        @album = Album.all.last
        @artist = @album.artists.first
        @song = @album.songs.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                   #       track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        @post_params2 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title + "  ",
                          dee_jay_id: user.id,
                   #       track_ordinal: 1,
                        },
                         commit: "Create" } 
                         
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        @song.artist = nil
        @song.save!
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does not create an Artist' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Artist.all.count }
      end
      
      it 'does not create a Song' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Song.all.count }
      end
      
      it 'does not create a Album' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a Album even when there is extra whitespace in the album title' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a Album even when there is extra whitespace in the existing album title' do
        @album.title = @album.title + "  "
        @album.save!
        
        Rails.logger.debug("RUNNING TEST WITH ALBUM TITLE: #{@album.title.inspect}")
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ RadioShow.all.count }
      end

      it 'does not create a Track' do
        expect{ post "/api/v1/songs", params: @post_params1.to_json, headers: headers }.not_to change{ Track.all.count }
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @track = Track.all.last
        @song.reload
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)        
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq( @song.title )
      end
      
      it 'sets the track ordinal to the last value for the radio_show track list' do
        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
        
        @radio_show = RadioShow.all.last
        @track = Track.all.last
        
#        expect(json).to eq("something")
        @track = Track.all.last
        expect(@track.ordinal).to eq( @radio_show.tracks.count )
      end
    end

    context 'when the request is valid double post for an existing artist, album, song combo with a track ordinal' do
      before do
        @track_ordinal = 5
        
        @album = Album.all.last
        @artist = @album.artists.first
        @song = @album.songs.first
        @post_params1 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                  #        track_ordinal: @track_ordinal - 1,
                        },
                        commit: "Create" } 
                         
        @post_params2 = { song: { publish_date: "2020-08-18",
                          title: @song.title,
                          artist_name: @artist.name,
                          album_title: @album.title,
                          dee_jay_id: user.id,
                          track_ordinal: @track_ordinal,
                        },
                        commit: "Create" } 

        post "/api/v1/songs", params: @post_params1.to_json, headers: headers 
      end

      it 'returns status code 201' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        expect(response).to have_http_status(201)
      end

      it 'does not create an Artist' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Artist.all.count }
      end
      
      it 'does not create a Song' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Song.all.count }
      end
      
      it 'does not create a Album' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Album.all.count }
      end

      it 'does not create a RadioShow' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ RadioShow.all.count }
      end

      it 'does not create a Track' do
        expect{ post "/api/v1/songs", params: @post_params2.to_json, headers: headers }.not_to change{ Track.all.count }
      end
      
      it 'should associate the records as expected' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers

        @radio_show = RadioShow.all.last
        @track = Track.all.last
        
        # Song.artist should point to Artist
        expect(@song.artist).to eq(@artist)
        
        # Song.album should point to Album
        expect(@song.album).to eq(@album)
        
        # RadioShow.songs should contain Song
        expect(@radio_show.songs).to include(@song)
        
        # Album.songs should contain Song
        expect(@album.songs).to include(@song)
        
        # Artist.albums should contain Album
        expect(@artist.albums).to include(@album)
        
        # RadioShow.tracks should include Track
        expect(@radio_show.tracks).to include(@track)        
      end
      
      it 'returns a Song' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        
#        expect(json).to eq("something")
        expect(json["title"]).to eq( @song.title )
      end
      
      it 'sets the track ordinal to the expected value' do
        post "/api/v1/songs", params: @post_params2.to_json, headers: headers 
        
#        expect(json).to eq("something")
        @track = Track.all.last
        expect(@track.ordinal).to eq( @track_ordinal )
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/songs', params: { race_class: "FOOBAR" }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

#      it 'returns a validation failure message' do
#        expect(response.body).to match(/Validation failed/)
#      end
    end

    context 'when the request is valid but double post with associated ids' do
      before do
        @post_params = { song: { publish_date: "2020-08-18",
                         artist_id: artist.id,
                         album_id: album.id,
                         song_id: song_id,
                         title: "A New Title",
                         dee_jay_id: user.id,
              #           track_ordinal: 1,
                       },
                         commit: "Create" }

        post "/api/v1/songs", :params => @post_params.to_json, :headers => headers
      end

      # Result is a PUT/PATCH
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

#      it 'returns some json' do
#        expect(json).to eq("something")
#      end
    end
  end

  # Test suite for PUT /api/v1/songs:id
  describe 'PUT /api/v1/songs/:id' do
    let(:valid_attributes) { {song: { title: "Piper's Song" }} }

    context 'when the record exists' do
      before { put "/api/v1/songs/#{song_id}", params: valid_attributes.to_json, headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end
end
