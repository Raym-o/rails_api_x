require 'test_helper'

class ProvincesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @province = provinces(:one)
  end

  test "should get index" do
    get provinces_url, as: :json
    assert_response :success
  end

  test "should create province" do
    assert_difference('Province.count') do
      post provinces_url, params: { province: { abbr: @province.abbr, hst_rate: @province.hst_rate, name: @province.name, pst_rate: @province.pst_rate } }, as: :json
    end

    assert_response 201
  end

  test "should show province" do
    get province_url(@province), as: :json
    assert_response :success
  end

  test "should update province" do
    patch province_url(@province), params: { province: { abbr: @province.abbr, hst_rate: @province.hst_rate, name: @province.name, pst_rate: @province.pst_rate } }, as: :json
    assert_response 200
  end

  test "should destroy province" do
    assert_difference('Province.count', -1) do
      delete province_url(@province), as: :json
    end

    assert_response 204
  end
end
