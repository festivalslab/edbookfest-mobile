class AddStockStatusToBook < ActiveRecord::Migration
  def change
    add_column :books, :stock_status, :string
  end
end
