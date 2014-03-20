class Lesson < ActiveRecord::Base
  
  has_many :slides
  
  belongs_to :course
  
  
end
