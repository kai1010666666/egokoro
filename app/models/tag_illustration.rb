class TagIllustration < ApplicationRecord
  # tag_illustrationテーブルは、illustrationsテーブルとtagsテーブルに属している
  #アソシエーション
  belongs_to :illustration
  belongs_to :tag
  # バリデーション
  validates :illustration_id, presence: true
  validates :tag_id, presence: true
end
