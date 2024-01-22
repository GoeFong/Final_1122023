require "application_system_test_case"

class CongviecsTest < ApplicationSystemTestCase
  setup do
    @congviec = congviecs(:one)
  end

  test "visiting the index" do
    visit congviecs_url
    assert_selector "h1", text: "Congviecs"
  end

  test "should create congviec" do
    visit congviecs_url
    click_on "New congviec"

    fill_in "Macongviec", with: @congviec.macongviec
    fill_in "Ngay bd", with: @congviec.ngay_bd
    fill_in "Ngay kt", with: @congviec.ngay_kt
    check "Status" if @congviec.status
    fill_in "Vanban", with: @congviec.vanban_id
    click_on "Create Congviec"

    assert_text "Congviec was successfully created"
    click_on "Back"
  end

  test "should update Congviec" do
    visit congviec_url(@congviec)
    click_on "Edit this congviec", match: :first

    fill_in "Macongviec", with: @congviec.macongviec
    fill_in "Ngay bd", with: @congviec.ngay_bd
    fill_in "Ngay kt", with: @congviec.ngay_kt
    check "Status" if @congviec.status
    fill_in "Vanban", with: @congviec.vanban_id
    click_on "Update Congviec"

    assert_text "Congviec was successfully updated"
    click_on "Back"
  end

  test "should destroy Congviec" do
    visit congviec_url(@congviec)
    click_on "Destroy this congviec", match: :first

    assert_text "Congviec was successfully destroyed"
  end
end
