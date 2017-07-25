require 'test_helper'

class MusicInfomationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @music_infomation = music_infomations(:one)
  end

  test "should get index" do
    get music_infomations_url, as: :json
    assert_response :success
  end

  test "should create music_infomation" do
    assert_difference('MusicInfomation.count') do
      post music_infomations_url, params: { music_infomation: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show music_infomation" do
    get music_infomation_url(@music_infomation), as: :json
    assert_response :success
  end

  test "should update music_infomation" do
    patch music_infomation_url(@music_infomation), params: { music_infomation: {  } }, as: :json
    assert_response 200
  end

  test "should destroy music_infomation" do
    assert_difference('MusicInfomation.count', -1) do
      delete music_infomation_url(@music_infomation), as: :json
    end

    assert_response 204
  end
end
