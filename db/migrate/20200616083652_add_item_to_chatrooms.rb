class AddItemToChatrooms < ActiveRecord::Migration[5.2]
  def change
    add_reference :chatrooms, :item, foreign_key: true
  end
end
