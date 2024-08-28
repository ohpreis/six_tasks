require "test_helper"

class MorningPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @morning_page = morning_pages(:one)
  end

  test "should get index" do
    get morning_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_morning_page_url
    assert_response :success
  end

  test "should create morning_page" do
    assert_difference("MorningPage.count") do
      post morning_pages_url, params: { morning_page: { body: @morning_page.body, user_id: @morning_page.user_id } }
    end

    assert_redirected_to morning_page_url(MorningPage.last)
  end

  test "should show morning_page" do
    get morning_page_url(@morning_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_morning_page_url(@morning_page)
    assert_response :success
  end

  test "should update morning_page" do
    patch morning_page_url(@morning_page), params: { morning_page: { body: @morning_page.body, user_id: @morning_page.user_id } }
    assert_redirected_to morning_page_url(@morning_page)
  end

  test "should destroy morning_page" do
    assert_difference("MorningPage.count", -1) do
      delete morning_page_url(@morning_page)
    end

    assert_redirected_to morning_pages_url
  end
end
