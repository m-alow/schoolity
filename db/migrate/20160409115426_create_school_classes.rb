class CreateSchoolClasses < ActiveRecord::Migration
  def change
    create_table :school_classes do |t|
      t.belongs_to :school, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
