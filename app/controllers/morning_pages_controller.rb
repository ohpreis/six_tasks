class MorningPagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_morning_page, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token


  # GET /morning_pages or /morning_pages.json
  def index
    ensure_morning_page_for_today

    # count the number of words in the morning page
    # and store it in the instance variable @word_count
    @word_count = count_words(@morning_page.body)
  end

  # Helper method to count words in the given content
  def count_words(content)
    # Strip HTML tags and count the words
    plain_text = ActionView::Base.full_sanitizer.sanitize(content)
    # Check first if there is any content
    return 0 if plain_text.blank?
    plain_text.split(/\s+/).count
  end

  def archive
    # Find all morning pages for the current user
    @pagy, @morning_pages = pagy(MorningPage.where(user: current_user).order(created_at: :desc))
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
    @morning_page.user = current_user

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
      puts params
      @morning_page.user = current_user
      if @morning_page.update(morning_page_params)
        format.html { redirect_to edit_morning_page_path(@morning_page), notice: "Morning page was successfully updated." }
        format.json { render json: { message: "ok" }, status: :ok }
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

    # Helper method to ensure a morning page exists for the current user and day
    def ensure_morning_page_for_today
      today_range = current_user_time_zone.now.beginning_of_day..current_user_time_zone.now.end_of_day

      # Find the morning page for the current user within the time range
      @morning_page = MorningPage.where(created_at: today_range, user: current_user).first

      # If no morning page is found, create a new one
      unless @morning_page
        @morning_page = MorningPage.create!(created_at: current_user_time_zone.now, user: current_user, body: "")
      end
    end

    # Helper method to get the current user's time zone
    def current_user_time_zone
      Time.use_zone(current_user.time_zone) { Time.zone }
    end
end
