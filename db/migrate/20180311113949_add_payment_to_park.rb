class AddPaymentToPark < ActiveRecord::Migration[5.1]
  def change
    add_column :parks, :paid, :boolean, default: false
  end
end
