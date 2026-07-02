class Api::V1::TracksController < ApplicationController
  before_action :set_track, only: %i[ show update destroy ]

  # GET /tracks
  def index
    @tracks = Track.includes([{:song => [:artist, :album]}]).all

    json_response(@tracks, includes: [{:song => {include: [:artist, :album]}}])
  end

  # GET /tracks/1
  def show
    json_response(@track, includes: [{:song => {include: [:artist, :album]}}])
  end

  def create

  end

  def update

  end

  def destroy

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.includes([{:song => [:artist, :album]}]).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.expect(track: [ :ordinal, :radio_show_id, :song_id ])
    end
end
