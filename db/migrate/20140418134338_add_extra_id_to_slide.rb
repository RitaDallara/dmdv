class AddExtraIdToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :extra_id, :integer
  end
end
