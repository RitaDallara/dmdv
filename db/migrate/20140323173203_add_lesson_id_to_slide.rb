class AddLessonIdToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :lesson_id, :integer
  end
end
