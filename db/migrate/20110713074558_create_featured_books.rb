class CreateFeaturedBooks < ActiveRecord::Migration
  def change
    create_table :featured_books do |t|
      t.integer :event_id
      t.integer :book_id

      t.timestamps
    end
  end
end
