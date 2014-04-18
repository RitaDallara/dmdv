class SlidesController < ApplicationController
  before_action :set_course
  before_action :set_lesson
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  # GET /slides
  # GET /slides.json
  def index
    @slides = @lesson.slides
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
  end

  # GET /slides/new
  def new
    @slide = Slide.new(:lesson => @lesson)
  end

  # GET /slides/1/edit
  def edit
  end

  # POST /slides
  # POST /slides.json
  def create
    @slide = @lesson.slides.new(slide_params)
    
    #@slide.position = 1

    respond_to do |format|
      if @slide.save
        format.html { redirect_to(course_lesson_slides_path(@course,@lesson)) }
        format.json { render action: 'show', status: :created, location: @slide }
      else
        format.html { render action: 'new' }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slides/1
  # PATCH/PUT /slides/1.json
  def update
    respond_to do |format|
      if @slide.update(slide_params)
        format.html { redirect_to(course_lesson_slide_path(@course,@lesson,@slide), notice: 'Slide was successfully updated.') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end


  
  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slide.destroy
    respond_to do |format|
      format.html { redirect_to course_lesson_slides_path(@course,@lesson) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slide
	@slide ||= Slide.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slide_params
      params.require(:slide).permit(:lesson_id, :title, :content, :previous, :next, :number, :position)
    end
    
        
    def set_course
      @course = Course.find params[:course_id]
    end
    
    def set_lesson
      @lesson = Lesson.find params[:lesson_id]
    end
end
