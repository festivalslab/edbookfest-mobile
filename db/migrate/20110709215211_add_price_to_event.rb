class AddPriceToEvent < ActiveRecord::Migration
  def change
    add_column :events, :price, :string
  end
end
