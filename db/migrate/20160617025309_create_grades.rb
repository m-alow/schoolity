class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.references :exam, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true
      t.decimal :score, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
