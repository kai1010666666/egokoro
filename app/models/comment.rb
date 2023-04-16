class Comment < ApplicationRecord
  #アソシエーション
  belongs_to :account
  belongs_to :illustration
  #バリデーション
  validates :comment, presence: true, length: { maximum: 20 }
end
