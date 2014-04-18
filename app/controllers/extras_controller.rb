class ExtrasController < ApplicationController
  before_action :set_course
  before_action :set_lesson
  before_action :set_slide
  before_action :set_extra, only: [:show, :edit, :update, :destroy]

  # GET /extras
  # GET /extras.json
  def index
    @extras = @slide.extras
  end

  # GET /extras/1
  # GET /extras/1.json
  def show
  end

  # GET /extras/new
  def new
    @extra = Extra.new(:slide => @slide)
  end

  # GET /extras/1/edit
  def edit
  end

  # POST /extras
  # POST /extras.json
  def create
    @extra = @slide.extras.new(extra_params)

    respond_to do |format|
      if @extra.save
        format.html { redirect_to(course_lesson_slide_extras_path(@course,@lesson,@slide)) }
        format.json { render action: 'show', status: :created, location: @extra }
      else
        format.html { render action: 'new' }
        format.json { render json: @extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extras/1
  # PATCH/PUT /extras/1.json
  def update
    respond_to do |format|
      if @extra.update(extra_params)
        format.html { redirect_to @extra, notice: 'Extra was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extras/1
  # DELETE /extras/1.json
  def destroy
    @extra.destroy
    respond_to do |format|
      format.html { redirect_to extras_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extra
      @extra = Extra.find(params[:id])
    end
    
    def set_slide
      @slide = Slide.find(params[:slide_id])
    end
    
    def set_course
      @course = Course.find(params[:course_id])
    end
    
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def extra_params
      params.require(:extra).permit(:title, :course_id, :lesson_id, :slide_id)
    end
end
