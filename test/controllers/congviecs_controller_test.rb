require "test_helper"

class CongviecsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @congviec = congviecs(:one)
  end

  test "should get index" do
    get congviecs_url
    assert_response :success
  end

  test "should get new" do
    get new_congviec_url
    assert_response :success
  end

  test "should create congviec" do
    assert_difference("Congviec.count") do
      post congviecs_url, params: { congviec: { macongviec: @congviec.macongviec, ngay_bd: @congviec.ngay_bd, ngay_kt: @congviec.ngay_kt, status: @congviec.status, vanban_id: @congviec.vanban_id } }
    end

    assert_redirected_to congviec_url(Congviec.last)
  end

  test "should show congviec" do
    get congviec_url(@congviec)
    assert_response :success
  end

  test "should get edit" do
    get edit_congviec_url(@congviec)
    assert_response :success
  end

  test "should update congviec" do
    patch congviec_url(@congviec), params: { congviec: { macongviec: @congviec.macongviec, ngay_bd: @congviec.ngay_bd, ngay_kt: @congviec.ngay_kt, status: @congviec.status, vanban_id: @congviec.vanban_id } }
    assert_redirected_to congviec_url(@congviec)
  end

  test "should destroy congviec" do
    assert_difference("Congviec.count", -1) do
      delete congviec_url(@congviec)
    end

    assert_redirected_to congviecs_url
  end
end
