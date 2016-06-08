class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.belongs_to :timetable, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.string :day
      t.integer :order

      t.timestamps null: false
    end
  end
end
