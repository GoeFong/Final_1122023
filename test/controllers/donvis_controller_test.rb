require "test_helper"

class DonvisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donvi = donvis(:one)
  end

  test "should get index" do
    get donvis_url
    assert_response :success
  end

  test "should get new" do
    get new_donvi_url
    assert_response :success
  end

  test "should create donvi" do
    assert_difference("Donvi.count") do
      post donvis_url, params: { donvi: { city: @donvi.city, country: @donvi.country, email: @donvi.email, sdt: @donvi.sdt, state: @donvi.state, status: @donvi.status, ten: @donvi.ten } }
    end

    assert_redirected_to donvi_url(Donvi.last)
  end

  test "should show donvi" do
    get donvi_url(@donvi)
    assert_response :success
  end

  test "should get edit" do
    get edit_donvi_url(@donvi)
    assert_response :success
  end

  test "should update donvi" do
    patch donvi_url(@donvi), params: { donvi: { city: @donvi.city, country: @donvi.country, email: @donvi.email, sdt: @donvi.sdt, state: @donvi.state, status: @donvi.status, ten: @donvi.ten } }
    assert_redirected_to donvi_url(@donvi)
  end

  test "should destroy donvi" do
    assert_difference("Donvi.count", -1) do
      delete donvi_url(@donvi)
    end

    assert_redirected_to donvis_url
  end
end
