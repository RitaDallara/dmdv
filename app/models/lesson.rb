class Lesson < ActiveRecord::Base
  
  has_many :slides, -> {order("position ASC") }
  
  belongs_to :course
  
  
end
