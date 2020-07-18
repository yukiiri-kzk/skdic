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
  has_many :chatrooms, class_name: 'Chatroom', foreign_key: 'exhibitor_id', dependent: :destroy
  has_many :wanters, through: :chatrooms, dependent: :destroy
  has_many :reverses_of_chatroom, class_name: 'Chatroom', foreign_key: 'wanter_id', dependent: :destroy
  has_many :exhibitors, through: :reverses_of_chatroom, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :talkrooms, through: :messages, source: :chatroom, dependent: :destroy
end
