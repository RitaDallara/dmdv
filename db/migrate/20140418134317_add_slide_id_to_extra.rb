class AddSlideIdToExtra < ActiveRecord::Migration
  def change
    add_column :extras, :slide_id, :integer
  end
end
