require "application_system_test_case"

class LcongviecTrangthaisTest < ApplicationSystemTestCase
  setup do
    @lcongviec_trangthai = lcongviec_trangthais(:one)
  end

  test "visiting the index" do
    visit lcongviec_trangthais_url
    assert_selector "h1", text: "Lcongviec trangthais"
  end

  test "should create lcongviec trangthai" do
    visit lcongviec_trangthais_url
    click_on "New lcongviec trangthai"

    fill_in "Color", with: @lcongviec_trangthai.color
    fill_in "Gia tri", with: @lcongviec_trangthai.gia_tri
    fill_in "Label", with: @lcongviec_trangthai.label
    click_on "Create Lcongviec trangthai"

    assert_text "Lcongviec trangthai was successfully created"
    click_on "Back"
  end

  test "should update Lcongviec trangthai" do
    visit lcongviec_trangthai_url(@lcongviec_trangthai)
    click_on "Edit this lcongviec trangthai", match: :first

    fill_in "Color", with: @lcongviec_trangthai.color
    fill_in "Gia tri", with: @lcongviec_trangthai.gia_tri
    fill_in "Label", with: @lcongviec_trangthai.label
    click_on "Update Lcongviec trangthai"

    assert_text "Lcongviec trangthai was successfully updated"
    click_on "Back"
  end

  test "should destroy Lcongviec trangthai" do
    visit lcongviec_trangthai_url(@lcongviec_trangthai)
    click_on "Destroy this lcongviec trangthai", match: :first

    assert_text "Lcongviec trangthai was successfully destroyed"
  end
end
