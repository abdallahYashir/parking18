class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :plate
      t.string :colour
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
