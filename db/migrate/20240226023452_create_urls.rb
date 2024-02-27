class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :url_complete
      t.string :url_short
      t.integer :count_visits
      t.timestamps
    end
  end
end
