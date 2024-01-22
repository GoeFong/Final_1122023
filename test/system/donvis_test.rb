require "application_system_test_case"

class DonvisTest < ApplicationSystemTestCase
  setup do
    @donvi = donvis(:one)
  end

  test "visiting the index" do
    visit donvis_url
    assert_selector "h1", text: "Donvis"
  end

  test "should create donvi" do
    visit donvis_url
    click_on "New donvi"

    fill_in "City", with: @donvi.city
    fill_in "Country", with: @donvi.country
    fill_in "Email", with: @donvi.email
    fill_in "Sdt", with: @donvi.sdt
    fill_in "State", with: @donvi.state
    fill_in "Status", with: @donvi.status
    fill_in "Ten", with: @donvi.ten
    click_on "Create Donvi"

    assert_text "Donvi was successfully created"
    click_on "Back"
  end

  test "should update Donvi" do
    visit donvi_url(@donvi)
    click_on "Edit this donvi", match: :first

    fill_in "City", with: @donvi.city
    fill_in "Country", with: @donvi.country
    fill_in "Email", with: @donvi.email
    fill_in "Sdt", with: @donvi.sdt
    fill_in "State", with: @donvi.state
    fill_in "Status", with: @donvi.status
    fill_in "Ten", with: @donvi.ten
    click_on "Update Donvi"

    assert_text "Donvi was successfully updated"
    click_on "Back"
  end

  test "should destroy Donvi" do
    visit donvi_url(@donvi)
    click_on "Destroy this donvi", match: :first

    assert_text "Donvi was successfully destroyed"
  end
end
