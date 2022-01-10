class Post < ApplicationRecord
  mount_uploaders :images, PostImageUploader
  validates :content, presence: true, length: { maximum: 500}
  validates :images, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
