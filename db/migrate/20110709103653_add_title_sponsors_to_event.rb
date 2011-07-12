class AddTitleSponsorsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :title_sponsors, :string
  end
end
