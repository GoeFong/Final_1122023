require "test_helper"

class LcongviecTrangthaisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lcongviec_trangthai = lcongviec_trangthais(:one)
  end

  test "should get index" do
    get lcongviec_trangthais_url
    assert_response :success
  end

  test "should get new" do
    get new_lcongviec_trangthai_url
    assert_response :success
  end

  test "should create lcongviec_trangthai" do
    assert_difference("LcongviecTrangthai.count") do
      post lcongviec_trangthais_url, params: { lcongviec_trangthai: { color: @lcongviec_trangthai.color, gia_tri: @lcongviec_trangthai.gia_tri, label: @lcongviec_trangthai.label } }
    end

    assert_redirected_to lcongviec_trangthai_url(LcongviecTrangthai.last)
  end

  test "should show lcongviec_trangthai" do
    get lcongviec_trangthai_url(@lcongviec_trangthai)
    assert_response :success
  end

  test "should get edit" do
    get edit_lcongviec_trangthai_url(@lcongviec_trangthai)
    assert_response :success
  end

  test "should update lcongviec_trangthai" do
    patch lcongviec_trangthai_url(@lcongviec_trangthai), params: { lcongviec_trangthai: { color: @lcongviec_trangthai.color, gia_tri: @lcongviec_trangthai.gia_tri, label: @lcongviec_trangthai.label } }
    assert_redirected_to lcongviec_trangthai_url(@lcongviec_trangthai)
  end

  test "should destroy lcongviec_trangthai" do
    assert_difference("LcongviecTrangthai.count", -1) do
      delete lcongviec_trangthai_url(@lcongviec_trangthai)
    end

    assert_redirected_to lcongviec_trangthais_url
  end
end
