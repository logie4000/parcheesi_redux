class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show update destroy ]

  # GET /artists
  def index
    @artists = Artist.all

    json_response(@artists)
  end

  # GET /artists/1
  def show
    json_response(@artist)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.expect(artist: [ :name, :comment ])
    end
end
