class Comment < ApplicationRecord
  validates :user_id, {presence: true}
  validates :post_id, {presence: true}
  validates :comment, {presence: true}
end
