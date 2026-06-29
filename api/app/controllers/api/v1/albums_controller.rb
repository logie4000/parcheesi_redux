class Api::V1::AlbumsController < ApplicationController
  before_action :set_album, only: [ :show ]

  # GET /albums
  def index
    @albums = Album.all

    json_response(@albums)
  end

  # GET /albums/1
  def show
    json_response(@album)
  end

  def create

  end

  def update

  end

  def destroy

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.expect(album: [ :title, :comment, :belongs_to ])
    end
end
