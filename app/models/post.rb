class Post < ApplicationRecord
  mount_uploaders :images, PostImageUploader
  validates :content, presence: true, length: { maximum: 500}
  validates :images, presence: true

  belongs_to :user
end
