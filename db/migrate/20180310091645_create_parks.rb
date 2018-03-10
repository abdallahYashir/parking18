class CreateParks < ActiveRecord::Migration[5.1]
  def change
    create_table :parks do |t|
      t.integer :number
      t.datetime :time_start
      t.datetime :time_end
      t.integer :total_amount
      t.text :comments
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
