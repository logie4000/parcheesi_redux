class Api::V1::SongsController < ApplicationController
  before_action :set_song, only: %i[ show update destroy ]

  # GET /songs
  def index
    @songs = Song.all

    json_response(@songs)
  end

  # GET /songs/1
  def show
    json_response(@song)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.expect(song: [ :title, :comment, :album_id, :total_plays, :artist_id ])
    end
end
