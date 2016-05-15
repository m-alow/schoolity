class CreateTeachings < ActiveRecord::Migration
  def change
    create_table :teachings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.references :classroom, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.boolean :all_subjects

      t.timestamps null: false
    end
  end
end
