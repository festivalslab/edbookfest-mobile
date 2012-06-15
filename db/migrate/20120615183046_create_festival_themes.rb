class CreateFestivalThemes < ActiveRecord::Migration
  def change
    create_table :festival_themes do |t|
      t.datetime :show_from
      t.has_attached_file :high
      t.has_attached_file :medium
      t.has_attached_file :low
      t.has_attached_file :shortcut
      t.has_attached_file :splash

      t.timestamps
    end
  end
end
