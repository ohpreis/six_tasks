require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should be invalid without a title" do
    task = Task.new(title: nil, status: :doing)
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "should be invalid with a title shorter than 3 characters" do
    task = Task.new(title: "ab", status: :doing)
    assert_not task.valid?
    assert_includes task.errors[:title], "is too short (minimum is 3 characters)"
  end

  test "should be valid with a title of at least 3 characters" do
    user = FactoryBot.create(:user)
    task = Task.new(title: "abc", status: :doing, user: user)
    unless task.valid?
      puts task.errors.full_messages
    end
    assert task.valid?
  end
end
