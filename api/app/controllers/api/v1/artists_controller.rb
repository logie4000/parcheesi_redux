class Api::V1::ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show update destroy ]

  # GET /artists
  def index
    @artists = Artist.includes(:albums, :songs).all.sort_by{|artist| [artist.significant_name]}

    json_response(@artists, includes: [:albums, :songs])
  end

  # GET /artists/1
  def show
    json_response(@artist, includes: [:albums, {:songs => {include: :album}}])
  end

  def create

  end

  def update

  end

  def destroy

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.includes(:albums, :songs).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.expect(artist: [ :name, :comment ])
    end
end
