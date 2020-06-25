class Item < ApplicationRecord
  validates :name, presence: true, length: {maximum: 255}
  validates :explanation, presence: true, length: {maximum: 300}
  mount_uploader :image, ItemImageUploader
  validates :image, presence: true
  validates :category_id, presence: true
  
  belongs_to :user
  belongs_to :category
  has_many :chatrooms
  has_many :wanter_items
  has_many :wanters, through: :wanter_items
end
