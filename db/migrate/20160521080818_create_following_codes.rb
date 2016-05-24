class CreateFollowingCodes < ActiveRecord::Migration
  def change
    create_table :following_codes do |t|
      t.references :student, index: true, foreign_key: true
      t.string :code, index: true
      t.datetime :expire_at

      t.timestamps null: false
    end
  end
end
