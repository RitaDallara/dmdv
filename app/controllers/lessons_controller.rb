class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :relocate]

  # GET /lessons
  # GET /lessons.json
  def index
    #@course= Course.find(params[:course_id])
    @lessons = @course.lessons
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = @course.lessons.new(lesson_params)
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = @course.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to(course_lesson_path(@course,@lesson), notice: 'Lesson was successfully created.') }
        format.json { render action: 'show', status: :created, location: @lesson }
      else
        format.html { render action: 'new' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def relocate
    if params[:parent_id]
      @slide= @lesson.slides.where(ancestry: params[:parent_id], position: params[:old].to_i + 1).first
    else
      @slide= @lesson.slides.where(ancestry: nil, position: params[:old].to_i + 1).first
    end
   # @slide= @lesson.slides.find(params[:slide_id])
    @slide.set_list_position(params[:new].to_i + 1)
    #@lesson.save_all
    #puts(@slide.position)
    
    render :nothing => true
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to [@course,@lesson], notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.fetch(:lesson, {}).permit(:course_id, :title)
    end
    
    def set_course
       @course = Course.find params[:course_id]
    end
end
