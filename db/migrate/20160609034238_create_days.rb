class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :classroom
      t.date :date
      t.string :content_type
      t.text :content

      t.timestamps null: false
    end
  end
end
