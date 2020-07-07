class AddCompletedToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :completed, :integer
  end
end
