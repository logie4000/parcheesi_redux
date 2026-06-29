class Api::V1::RadioShowsController < ApplicationController
  before_action :set_radio_show, only: %i[ show update destroy ]

  # GET /radio_shows
  def index
    @radio_shows = RadioShow.all

    render json: @radio_shows
  end

  # GET /radio_shows/1
  def show
    render json: @radio_show
  end

  # POST /radio_shows
  def create
    @radio_show = RadioShow.new(radio_show_params)

    if @radio_show.save
      render json: @radio_show, status: :created, location: @radio_show
    else
      render json: @radio_show.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /radio_shows/1
  def update
    if @radio_show.update(radio_show_params)
      render json: @radio_show
    else
      render json: @radio_show.errors, status: :unprocessable_content
    end
  end

  # DELETE /radio_shows/1
  def destroy
    @radio_show.destroy!
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
