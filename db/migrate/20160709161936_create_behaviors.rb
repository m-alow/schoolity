class CreateBehaviors < ActiveRecord::Migration
  def change
    create_table :behaviors do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.references :behaviorable, polymorphic: true, index: true
      t.string :content_type
      t.text :content

      t.timestamps null: false
    end
  end
end
