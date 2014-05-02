class AddAncestryToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :ancestry, :string
  end
end
