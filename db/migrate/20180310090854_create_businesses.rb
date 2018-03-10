class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :location

      t.timestamps
    end
  end
end
