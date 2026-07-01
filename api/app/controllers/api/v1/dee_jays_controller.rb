class Api::V1::DeeJaysController < ApplicationController
  before_action :set_dee_jay, only: %i[ show update destroy ]

  # GET /dee_jays
  def index
    @dee_jays = DeeJay.all

    json_response(@dee_jays)
  end

  # GET /dee_jays/1
  def show
    json_response(@dee_jay, includes: [:radio_shows, :songs])
  end

  def create

  end

  def update

  end

  def destroy

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dee_jay
      @dee_jay = DeeJay.includes(:radio_shows, :songs).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def dee_jay_params
      params.expect(dee_jay: [ :name, :email, :mixcloud_user ])
    end
end
