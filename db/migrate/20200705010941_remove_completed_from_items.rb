class RemoveCompletedFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :completed, :integer
  end
end
