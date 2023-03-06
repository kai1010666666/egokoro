class TagIllustration < ApplicationRecord
      # tag_illustrationテーブルは、illustrationsテーブルとtagsテーブルに属している
  belongs_to :illustration
  belongs_to :tag

  # 念のためのバリデーション
  validates :illustration_id, presence: true
  validates :tag_id, presence: true
end
