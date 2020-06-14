class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :self_introduction, allow_blank: true, length: { maximum: 300 }
  has_secure_password
  mount_uploader :image, ProfileImageUploader
  
  has_many :items, dependent: :destroy
end
