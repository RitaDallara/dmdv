class Slide < ActiveRecord::Base
  
  has_ancestry
  
  belongs_to :lesson
  
  acts_as_list scope: :lesson
  
  acts_as_list scope: [:ancestry]
  
  #default_scope order: :position
  
end
