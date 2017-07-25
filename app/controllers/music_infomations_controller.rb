class MusicInfomationsController < ApplicationController
  before_action :set_music_infomation, only: [:show, :update, :destroy]

  # GET /music_infomations
  def index
    @music_infomations = MusicInfomation.all

    render json: @music_infomations
  end

  # GET /music_infomations/1
  def show
    render json: @music_infomation
  end

  # POST /music_infomations
  def create
    @music_infomation = MusicInfomation.new(music_infomation_params)

    if @music_infomation.save
      render json: @music_infomation, status: :created, location: @music_infomation
    else
      render json: @music_infomation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /music_infomations/1
  def update
    if @music_infomation.update(music_infomation_params)
      render json: @music_infomation
    else
      render json: @music_infomation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /music_infomations/1
  def destroy
    @music_infomation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music_infomation
      @music_infomation = MusicInfomation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def music_infomation_params
      params.fetch(:music_infomation, {})
    end
end
