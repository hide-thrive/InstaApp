class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 500}
  validates :images, presence: true

  belongs_to :user
end
