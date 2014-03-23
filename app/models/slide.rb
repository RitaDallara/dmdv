class Slide < ActiveRecord::Base
  
  belongs_to :lesson
  
  acts_as_list scope: :lesson
  
end
