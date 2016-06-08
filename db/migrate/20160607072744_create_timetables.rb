class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.belongs_to :classroom, index: true, foreign_key: true
      t.boolean :active
      t.text :weekends
      t.integer :periods_number

      t.timestamps null: false
    end
  end
end
