class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.references :announceable, polymorphic: true, index: true
      t.references :author
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
