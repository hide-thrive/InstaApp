class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :email, uniqueness: true, presence: true,
  length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },

  vaildates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
