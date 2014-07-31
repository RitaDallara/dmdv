class SlidesController < ApplicationController
  before_action :set_course
  before_action :set_lesson
  before_action :set_slide, only: [:show, :edit, :update, :destroy]

  # GET /slides
  # GET /slides.json
  def index
    if params[:parent_id]
      @slides = @lesson.slides.where(:ancestry => params[:parent_id])
    else
      @slides = @lesson.slides.where(:ancestry => nil)
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  
  def slide_content
   
    if not File.exist?("#{Rails.root}/public/tmp/lesson_#{@lesson.id}.zip")
      ip_client = request.remote_ip
      dir="#{Rails.root}/public/tmp/#{ip_client}/"
      Dir.mkdir(dir) unless File.directory?(dir)
      @lesson.slides.each do |s|
	@slide = s
	content = render_to_string
	File.open("public/tmp/#{ip_client}/#{s.id}_#{@lesson.title}.html", "w+") do |f|
	  f.write(content)
	end
      end
      
      zip_name = "#{Rails.root}/public/tmp/lesson_#{@lesson.id}.zip"
      Zip::File.open(zip_name,Zip::File::CREATE) do |zipfile|
	Dir[File.join(dir,'**','**')].each do |file|
	zipfile.add(file.sub(dir, ''),file)
	end
      end

      
    end
    
     
    send_file "#{Rails.root}/public/tmp/lesson_#{@lesson.id}.zip", :type => 'application/zip', :disposition => 'attachment', :filename => "lesson_#{@lesson.id}.zip", :stream => false
      
    FileUtils.remove_dir(dir,true)

  end
    
  def show
    if params[:download]
    #send_data(render_to_string, :filename => "object.html", :type => "text/html")
      content = render_to_string
      File.open("public/tmp/slide1.html", "w+") do |f|
      f.write(content)
      end
  else
    # render normally
  end
  end

  # GET /slides/new
  def new
    #@slide = Slide.new(:lesson => @lesson, :parent_id => params[:parent_id])
    #@slide = Slide.new(slide_params)
    if params[:parent_id]
      @slide = Slide.find(params[:parent_id]).children.new(:lesson => @lesson)
    else
      @slide = Slide.new(:lesson => @lesson)
    end
      
  end

    
  # GET /slides/1/edit
  def edit
  end

  # POST /slides
  # POST /slides.json
  def create
    if params[:parent_id]
      @slide = Slide.find(params[:parent_id]).children.new(:lesson => @lesson)
    else
      @slide = @lesson.slides.new(slide_params)
    end
   # @slide.extra_id= params[:extra_id]
    
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
      params.require(:slide).permit(:lesson_id, :title, :content, :previous, :next, :number, :position, :parent_id)
    end
    
        
    def set_course
      @course = Course.find params[:course_id]
    end
    
    def set_lesson
      @lesson = Lesson.find params[:lesson_id]
    end
end
