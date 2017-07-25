require 'test_helper'

class TransactionLyricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction_lyric = transaction_lyrics(:one)
  end

  test "should get index" do
    get transaction_lyrics_url, as: :json
    assert_response :success
  end

  test "should create transaction_lyric" do
    assert_difference('TransactionLyric.count') do
      post transaction_lyrics_url, params: { transaction_lyric: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show transaction_lyric" do
    get transaction_lyric_url(@transaction_lyric), as: :json
    assert_response :success
  end

  test "should update transaction_lyric" do
    patch transaction_lyric_url(@transaction_lyric), params: { transaction_lyric: {  } }, as: :json
    assert_response 200
  end

  test "should destroy transaction_lyric" do
    assert_difference('TransactionLyric.count', -1) do
      delete transaction_lyric_url(@transaction_lyric), as: :json
    end

    assert_response 204
  end
end
