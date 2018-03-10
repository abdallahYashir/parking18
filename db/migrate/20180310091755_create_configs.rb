class CreateConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :configs do |t|
      t.integer :amount_per_hour
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
