class Api::V1::SongsController < ApplicationController
  before_action :set_song, only: %i[ show update destroy ]

  # GET /api/v1/songs
  def index
    if (params[:radio_show_id])
      @radio_show = RadioShow.find(params[:radio_show_id])
      @songs = @radio_show.songs.order(:title)
    else
      @songs = Song.all.order(:title)
    end

    json_response(@songs)
  end

  #GET /api/v1/songs/:id
  def show
    json_response(@song, includes: [:artist, :album, :radio_shows])
  end

  # POST /songs
  def create
    Rails.logger.debug("Started create call at #{Time.now.utc}")
    begin
      song_params
    rescue StandardError => e
      Rails.logger.error "Song.create > song_params raised StandardError #{e.inspect}"
      raise ActiveRecord::RecordInvalid
    end

    @song = Song.post_song(params, @current_user.id)
    Rails.logger.debug("Returning json response at #{Time.now.utc}")
    json_response(@song, status: :created)
    Rails.logger.debug("Ended create call at #{Time.now.utc}")
  end

  # PATCH/PUT /songs/1
  def update
    if @song.update(song_params)
      head :no_content
    else
      render json: @song.errors, status: :unprocessable_content
    end
  end

  # DELETE /songs/1
  def destroy
    @song.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.includes([:artist, :album, :radio_shows]).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.expect(song: [ :title, :comment, :album_id, :total_plays, :artist_id ])
    end
end
