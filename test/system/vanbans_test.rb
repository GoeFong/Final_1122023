require "application_system_test_case"

class VanbansTest < ApplicationSystemTestCase
  setup do
    @vanban = vanbans(:one)
  end

  test "visiting the index" do
    visit vanbans_url
    assert_selector "h1", text: "Vanbans"
  end

  test "should create vanban" do
    visit vanbans_url
    click_on "New vanban"

    fill_in "Level", with: @vanban.level
    fill_in "Link to apply", with: @vanban.link_to_apply
    fill_in "Title", with: @vanban.title
    fill_in "User", with: @vanban.user_id
    click_on "Create Vanban"

    assert_text "Vanban was successfully created"
    click_on "Back"
  end

  test "should update Vanban" do
    visit vanban_url(@vanban)
    click_on "Edit this vanban", match: :first

    fill_in "Level", with: @vanban.level
    fill_in "Link to apply", with: @vanban.link_to_apply
    fill_in "Title", with: @vanban.title
    fill_in "User", with: @vanban.user_id
    click_on "Update Vanban"

    assert_text "Vanban was successfully updated"
    click_on "Back"
  end

  test "should destroy Vanban" do
    visit vanban_url(@vanban)
    click_on "Destroy this vanban", match: :first

    assert_text "Vanban was successfully destroyed"
  end
end
