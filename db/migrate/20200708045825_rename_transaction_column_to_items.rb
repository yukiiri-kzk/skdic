class RenameTransactionColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :transaction, :done
  end
end
