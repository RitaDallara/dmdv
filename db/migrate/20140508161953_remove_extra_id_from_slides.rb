class RemoveExtraIdFromSlides < ActiveRecord::Migration
  def change
    remove_column :slides, :extra_id, :integer
  end
end
