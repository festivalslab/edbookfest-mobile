class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer   :eibf_id
      t.string    :title
      t.string    :sub_title
      t.string    :standfirst
      t.datetime  :start_time
      t.date      :date
      t.boolean   :is_sold_out
      t.string    :event_type

      t.timestamps
    end
  end
end
