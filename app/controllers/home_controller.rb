class HomeController < ApplicationController
  before_action :set_layout

  def index
    @task = Task.new
    @doing = Task.where(status: :doing).where(user: current_user)
    @backlog = Task.where(status: :backlog).where(user: current_user)
    @ideas = Task.where(status: :idea).where(user: current_user)
  end

  def completed
        @pagy, @completed_tasks = pagy(Task.where(status: "done").where(user: current_user.id).order(created_at: :desc))
  end

  def help
  end

  private

  def set_layout
    if user_signed_in?
      self.class.layout "application"
    else
      self.class.layout "application"
    end
  end

  def user_signed_in?
    current_user.present?
  end
end
