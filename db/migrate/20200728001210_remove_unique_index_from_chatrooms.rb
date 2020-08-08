class RemoveUniqueIndexFromChatrooms < ActiveRecord::Migration[5.2]
  def change
    remove_index :chatrooms, column: [:exhibitor_id, :wanter_id]
  end
end
