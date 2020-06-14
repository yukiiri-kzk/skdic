class Item < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: {maximum: 255}
  validates :explanation, presence: true, length: {maximum: 300}
  mount_uploader :image, ItemImageUploader
  validates :image, presence: true
end
