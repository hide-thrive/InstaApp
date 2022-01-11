class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  validates :email, uniqueness: true, presence: true,
  length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  validates :password, presence: true, confirmation: true, length: {minimum: 3} , if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower

  # Postcontroller#indexの@users取得(5)に使用
  scope :recent, -> (count) { order(created_at: :desc).limit(count) }

  def own?(object)
    id == object.user_id
  end

  def liked?(post)
    like_posts.include?(post)
  end

  def like(post)
    like_posts << post
  end

  def unlike(post)
    like_posts.destroy(post)
  end

  # フォローしているユーザーのpostsを取得する
  def feed
    Post.where(user_id: following_ids << id)
  end

  # フォローする
  def follow(other_user)
    following << other_user
  end

  # フォロー解除
  def unfollow(other_user)
    following.destroy(other_user)
  end

  # フォローしているか?
  def following?(other_user)
    following.include?(other_user)
  end
end

# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
