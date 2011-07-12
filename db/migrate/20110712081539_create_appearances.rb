class CreateAppearances < ActiveRecord::Migration
  def change
    create_table :appearances do |t|
      t.integer :event_id
      t.integer :author_id

      t.timestamps
    end
  end
end
