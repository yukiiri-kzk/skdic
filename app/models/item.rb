class Item < ApplicationRecord
  validates :name, presence: true, length: {maximum: 255}
  validates :explanation, presence: true, length: {maximum: 255}
  mount_uploader :image, ItemImageUploader
  validates :image, presence: true
  validates :category_id, presence: true
  validates :area_id, presence: true

  belongs_to :user
  belongs_to :category
  belongs_to :area
  has_many :chatrooms, dependent: :destroy
  
  scope :get_by_name, ->(name) {
    where('name like?', "%#{name}%")
  }
  scope :get_by_category, ->(category_id) {
    where(category_id: category_id)
  }
  scope :get_by_area, ->(area_id) {
    where(area_id: area_id)
  }
end
