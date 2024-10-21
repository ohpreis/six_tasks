require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end


  test "should update Task" do
    visit task_url(@task)

    click_on "Update"

    assert_text "Task was successfully updated"
    click_on "Back"
  end
end
