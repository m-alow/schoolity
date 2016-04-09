class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.belongs_to :school_class, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
