class Extra < ActiveRecord::Base
  has_many :slides, -> {order("position ASC") }
  
  belongs_to :slide
end
