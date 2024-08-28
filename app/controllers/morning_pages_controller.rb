class MorningPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_morning_page, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /morning_pages or /morning_pages.json
  def index
    if MorningPage.exists?(created_at: Date.today.midnight..Date.today.end_of_day)
      @morning_page = MorningPage.find_by(created_at: Date.today.midnight..Date.today.end_of_day)
    else
      @morning_page = MorningPage.create!(created_at: Date.today, user: current_user, body: "get started")
    end
  end

  # GET /morning_pages/1 or /morning_pages/1.json
  def show
  end

  # GET /morning_pages/new
  def new
    @morning_page = MorningPage.new
  end

  # GET /morning_pages/1/edit
  def edit
  end

  # POST /morning_pages or /morning_pages.json
  def create
    @morning_page = MorningPage.new(morning_page_params)

    respond_to do |format|
      if @morning_page.save
        format.html { redirect_to morning_page_url(@morning_page), notice: "Morning page was successfully created." }
        format.json { render :show, status: :created, location: @morning_page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @morning_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /morning_pages/1 or /morning_pages/1.json
  def update
    respond_to do |format|
      if @morning_page.update(morning_page_params)
        format.html { redirect_to edit_morning_page_path(@morning_page), notice: "Morning page was successfully updated." }
        format.json { render :show, status: :ok, location: @morning_page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @morning_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /morning_pages/1 or /morning_pages/1.json
  def destroy
    @morning_page.destroy!

    respond_to do |format|
      format.html { redirect_to morning_pages_url, notice: "Morning page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_morning_page
      @morning_page = MorningPage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def morning_page_params
      params.require(:morning_page).permit(:body, :user_id)
    end
end
