class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :classroom, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.integer :score
      t.integer :minimum_score
      t.date :date
      t.text :description

      t.timestamps null: false
    end
  end
end
