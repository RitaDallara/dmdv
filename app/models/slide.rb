class Slide < ActiveRecord::Base
  
  has_many :extras
  
  belongs_to :lesson
  
  acts_as_list scope: :lesson
  
end
