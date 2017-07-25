require 'test_helper'

class LyricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lyric = lyrics(:one)
  end

  test "should get index" do
    get lyrics_url, as: :json
    assert_response :success
  end

  test "should create lyric" do
    assert_difference('Lyric.count') do
      post lyrics_url, params: { lyric: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show lyric" do
    get lyric_url(@lyric), as: :json
    assert_response :success
  end

  test "should update lyric" do
    patch lyric_url(@lyric), params: { lyric: {  } }, as: :json
    assert_response 200
  end

  test "should destroy lyric" do
    assert_difference('Lyric.count', -1) do
      delete lyric_url(@lyric), as: :json
    end

    assert_response 204
  end
end
