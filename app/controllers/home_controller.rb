class HomeController < ApplicationController
  def index
    @task = Task.new
    @doing = Task.where(status: :doing).where(user: current_user)
    @backlog = Task.where(status: :backlog).where(user: current_user)
    @ideas = Task.where(status: :idea).where(user: current_user)
  end

  def completed
    @pagy, @completed_tasks = pagy(Task.where(status: "done").where(user: current_user.id))
  end

  def help
  end

  private

  def set_morning_page
    today = Date.current
    if MorningPage.exists?(created_at: today.midnight..today.end_of_day)
      @morning_page = MorningPage.find_by(created_at: today.midnight..today.end_of_day).first
    else
      @morning_page = MorningPage.create!(created_at: today, user: current_user, body: "get started")
    end
  end
end
