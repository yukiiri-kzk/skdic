class Chatroom < ApplicationRecord
  belongs_to :exhibitor, class_name: "User"
  belongs_to :wanter, class_name: "User"
  belongs_to :item
  has_many :messages
  has_many :users, through: :messages
  has_many :items
end
