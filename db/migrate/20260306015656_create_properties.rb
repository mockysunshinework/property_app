class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.integer :price, null: false
      t.text :description
      t.string :nearest_station
      t.integer :minutes_by_walk

      t.timestamps
    end
  end
end
