class User < ApplicationRecord
  validates :name, {presence: true, uniqueness: true, length: {maximum: 12}}
  validates :password, {presence: true, uniqueness: true}

  def posts
    return Post.where(user_id: self.id).order(updated_at: :desc)
  end
end
