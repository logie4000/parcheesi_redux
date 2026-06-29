class Api::V1::TracksController < ApplicationController
  before_action :set_track, only: %i[ show update destroy ]

  # GET /tracks
  def index
    @tracks = Track.all

    json_response(@tracks)
  end

  # GET /tracks/1
  def show
    json_response(@track)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def track_params
      params.expect(track: [ :ordinal, :radio_show_id, :song_id ])
    end
end
