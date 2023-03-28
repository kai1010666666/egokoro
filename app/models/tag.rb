class Tag < ApplicationRecord
  #tag_mapsと関連付けを行い、tag_mapsのテーブルを通しpostsテーブルと関連づけ
  #dependent: :destroyをつけることで、タグが削除された時にタグの関連付けを削除する
  has_many :tag_illustrations, dependent: :destroy, foreign_key: 'tag_id'
  #postsのアソシエーション
  #Tag.postsとすれば、タグに紐付けられたPostを取得可能になる
  has_many :illustrations, through: :tag_illustrations
end