class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.references :day, index: true, foreign_key: true
      t.text :notes

      t.timestamps null: false
    end
  end
end
