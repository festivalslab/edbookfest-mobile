class AddMainSiteUrlToEvent < ActiveRecord::Migration
  def change
    add_column :events, :main_site_url, :string
  end
end
