class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :description
      t.decimal :price
      t.string :image

      t.timestamps
    end
  end
end
