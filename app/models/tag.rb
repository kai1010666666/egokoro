class Tag < ApplicationRecord
  #tag_mapsと関連付けを行い、tag_mapsのテーブルを通しillustrationsテーブルと関連づけ
  #dependent: :destroyをつけることで、タグが削除された時にタグの関連付けを削除する
  has_many :tag_illustrations, dependent: :destroy
  #illustrationsのアソシエーション
  #Tag.illustrationsとすれば、タグに紐付けられたIllustrationを取得可能になる
  has_many :illustrations, through: :tag_illustrations
end