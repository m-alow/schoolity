class CreateSchoolAdministrations < ActiveRecord::Migration
  def change
    create_table :school_administrations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
