class HomeController < ApplicationController
  def index
    @task = Task.new
    @doing = Task.where(status: :doing).where(user: current_user)
    @backlog = Task.where(status: :backlog).where(user: current_user)
    @ideas = Task.where(status: :idea).where(user: current_user)
  end
end
