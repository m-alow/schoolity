class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.belongs_to :school, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :father_name
      t.string :mother_name
      t.date :birthdate

      t.timestamps null: false
    end
  end
end
