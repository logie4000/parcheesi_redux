class Api::V1::RadioShowsController < ApplicationController
  before_action :set_radio_show, only: %i[ show update destroy ]

  # GET /radio_shows
  def index
    @radio_shows = RadioShow.all

    json_response(@radio_shows)
  end

  # GET /radio_shows/1
  def show
    json_response(@radio_show)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_radio_show
      @radio_show = RadioShow.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def radio_show_params
      params.expect(radio_show: [ :publish_date, :title, :comment, :dee_jay_id, :web_link ])
    end
end
