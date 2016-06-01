class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.string :relationship

      t.timestamps null: false
    end
  end
end
