class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy change_status ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  def change_status
    if Task.statuses.keys.include?(params[:status])
      @task.update(status: params[:status])
      redirect_to home_index_path, notice: "Task status was successfully updated."
    else
      redirect_to home_index_path, alert: "Invalid status."
    end
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    status(@task)

    respond_to do |format|
      if @task.save
        format.html { redirect_to home_index_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def status(task)
    pattern = /@doing|@idea/
    last_occurrence = @task.title.match(pattern).to_s

    status_map = { "@doing" => "doing", "@idea" => "idea" }

    if last_occurrence.present?
      @task.status = status_map[last_occurrence]
      @task.title = @task.title.reverse.sub(last_occurrence.reverse, "").reverse
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      @task.user = current_user
      if @task.update(task_params)
        format.html { redirect_to edit_task_path(@task), notice: "Task was successfully updated." }
        format.json { render json: { message: "ok" }, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to root_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :status, :user_id)
    end
end
