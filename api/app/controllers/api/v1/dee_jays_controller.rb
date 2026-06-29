class Api::V1::DeeJaysController < ApplicationController
  before_action :set_dee_jay, only: %i[ show update destroy ]

  # GET /dee_jays
  def index
    @dee_jays = DeeJay.all

    render json: @dee_jays
  end

  # GET /dee_jays/1
  def show
    render json: @dee_jay
  end

  # POST /dee_jays
  def create
    @dee_jay = DeeJay.new(dee_jay_params)

    if @dee_jay.save
      render json: @dee_jay, status: :created, location: @dee_jay
    else
      render json: @dee_jay.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /dee_jays/1
  def update
    if @dee_jay.update(dee_jay_params)
      render json: @dee_jay
    else
      render json: @dee_jay.errors, status: :unprocessable_content
    end
  end

  # DELETE /dee_jays/1
  def destroy
    @dee_jay.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dee_jay
      @dee_jay = DeeJay.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def dee_jay_params
      params.expect(dee_jay: [ :name, :email, :mixcloud_user ])
    end
end
