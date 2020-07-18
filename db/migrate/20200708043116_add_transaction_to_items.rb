class AddTransactionToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :transaction, :string
  end
end
