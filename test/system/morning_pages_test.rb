require "application_system_test_case"

class MorningPagesTest < ApplicationSystemTestCase
  setup do
    @morning_page = morning_pages(:one)
  end

  test "visiting the index" do
    visit morning_pages_url
    assert_selector "h1", text: "Morning pages"
  end

  test "should create morning page" do
    visit morning_pages_url
    click_on "New morning page"

    fill_in "Body", with: @morning_page.body
    fill_in "User", with: @morning_page.user_id
    click_on "Create Morning page"

    assert_text "Morning page was successfully created"
    click_on "Back"
  end

  test "should update Morning page" do
    visit morning_page_url(@morning_page)
    click_on "Edit this morning page", match: :first

    fill_in "Body", with: @morning_page.body
    fill_in "User", with: @morning_page.user_id
    click_on "Update Morning page"

    assert_text "Morning page was successfully updated"
    click_on "Back"
  end

  test "should destroy Morning page" do
    visit morning_page_url(@morning_page)
    click_on "Destroy this morning page", match: :first

    assert_text "Morning page was successfully destroyed"
  end
end
