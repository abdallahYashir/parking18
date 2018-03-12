class RemoveBusinessFieldFromUser < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :business
    remove_reference :users, :business, foreign_key: true
  end
end
