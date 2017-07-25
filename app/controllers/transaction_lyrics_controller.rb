class TransactionLyricsController < ApplicationController
  before_action :set_transaction_lyric, only: [:show, :update, :destroy]

  # GET /transaction_lyrics
  def index
    @transaction_lyrics = TransactionLyric.all

    render json: @transaction_lyrics
  end

  # GET /transaction_lyrics/1
  def show
    render json: @transaction_lyric
  end

  # POST /transaction_lyrics
  def create
    @transaction_lyric = TransactionLyric.new(transaction_lyric_params)

    if @transaction_lyric.save
      render json: @transaction_lyric, status: :created, location: @transaction_lyric
    else
      render json: @transaction_lyric.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transaction_lyrics/1
  def update
    if @transaction_lyric.update(transaction_lyric_params)
      render json: @transaction_lyric
    else
      render json: @transaction_lyric.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transaction_lyrics/1
  def destroy
    @transaction_lyric.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_lyric
      @transaction_lyric = TransactionLyric.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def transaction_lyric_params
      params.fetch(:transaction_lyric, {})
    end
end
