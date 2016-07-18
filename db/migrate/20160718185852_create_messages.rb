class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true
      t.string :message_type
      t.string :content_type
      t.text :content

      t.timestamps null: false
    end
  end
end
