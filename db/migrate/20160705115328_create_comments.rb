class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.belongs_to :user, index: true, foreign_key: true
      t.text :body
      t.string :role

      t.timestamps null: false
    end
  end
end
