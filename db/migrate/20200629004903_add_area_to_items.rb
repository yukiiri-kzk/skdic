class AddAreaToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :area, foreign_key: true
  end
end
