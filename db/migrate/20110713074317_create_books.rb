class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :eibf_id
      t.string :title
      t.string :amazon_url
      t.string :isbn
      t.string :amazon_image

      t.timestamps
    end
  end
end
