class HomeController < ApplicationController
  def index
    @task = Task.new
    @doing = Task.where(status: :doing).where(user: current_user)
    @backlog = Task.where(status: :backlog).where(user: current_user)
    @ideas = Task.where(status: :idea).where(user: current_user)
  end

  def completed
    @completed_tasks = Task.where(status: "done").where(user: current_user.id)
  end

  def help
  end
end
