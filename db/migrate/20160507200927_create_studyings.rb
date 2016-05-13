class CreateStudyings < ActiveRecord::Migration
  def change
    create_table :studyings do |t|
      t.belongs_to :classroom, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true
      t.date :beginning_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
