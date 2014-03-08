class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :title
      t.text :content
      t.integer :previous
      t.integer :next
      t.integer :number

      t.timestamps
    end
  end
end
