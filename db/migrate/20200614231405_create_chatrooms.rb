class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.references :exhibitor, foreign_key: { to_table: :users }
      t.references :wanter, foreign_key: { to_table: :users }

      t.timestamps
      
      
      t.index [:exhibitor_id, :wanter_id], unique: true
    end
  end
end
