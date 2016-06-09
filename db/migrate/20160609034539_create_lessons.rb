class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.belongs_to :day, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :order
      t.string :content_type
      t.text :content

      t.timestamps null: false
    end
  end
end
