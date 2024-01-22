require "test_helper"

class VanbansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vanban = vanbans(:one)
  end

  test "should get index" do
    get vanbans_url
    assert_response :success
  end

  test "should get new" do
    get new_vanban_url
    assert_response :success
  end

  test "should create vanban" do
    assert_difference("Vanban.count") do
      post vanbans_url, params: { vanban: { level: @vanban.level, link_to_apply: @vanban.link_to_apply, title: @vanban.title, user_id: @vanban.user_id } }
    end

    assert_redirected_to vanban_url(Vanban.last)
  end

  test "should show vanban" do
    get vanban_url(@vanban)
    assert_response :success
  end

  test "should get edit" do
    get edit_vanban_url(@vanban)
    assert_response :success
  end

  test "should update vanban" do
    patch vanban_url(@vanban), params: { vanban: { level: @vanban.level, link_to_apply: @vanban.link_to_apply, title: @vanban.title, user_id: @vanban.user_id } }
    assert_redirected_to vanban_url(@vanban)
  end

  test "should destroy vanban" do
    assert_difference("Vanban.count", -1) do
      delete vanban_url(@vanban)
    end

    assert_redirected_to vanbans_url
  end
end
