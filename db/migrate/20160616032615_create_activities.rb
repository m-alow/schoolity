class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
      t.string :content_type
      t.text :content

      t.timestamps null: false
    end
  end
end
