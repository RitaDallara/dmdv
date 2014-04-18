class Lesson < ActiveRecord::Base
  
  has_many :slides, -> {order("position ASC") }
  
  belongs_to :course
  
  def save_all
    slides = Slide.where(lesson_id: id)
    slides.each do |s|
      s.save!
    end
  end
  
  
end
