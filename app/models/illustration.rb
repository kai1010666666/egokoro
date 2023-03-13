class Illustration < ApplicationRecord
  belongs_to :account
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', _type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.search(search) #self.でクラスメソッドとしている
    if search# Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Illustration.where(['title LIKE ?', "%#{search}%"])
    else
      Illustration.all #全て表示。
    end
  end

  # dependent: :destroyでIllustrationが削除されると同時にIllustrationとTagの関係が削除される
  has_many :tag_illustrations, dependent: :destroy

  # throughを利用して、tag_mapsを通してtagsとの関連付け(中間テーブル)
  #   Illustration.tagsとすれば、Illustrationに紐付けられたTagの取得が可能
  has_many :tags, through: :tag_illustrations

  # バリデーション
  validates :title, presence: true
  validates :introduction, presence: true
  validates :image, presence: true
  def save_tags(tags)

    # タグをスペース区切りで分割し配列にする
    #   連続した空白も対応するので、最後の“+”がポイント
    tag_list = tags.split(/[[:blank:]]+/)

    # 自分自身に関連づいたタグを取得する
    current_tags = self.tags.pluck(:name)

    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    #   -- 記事更新時に削除されたタグ
    old_tags = current_tags - tag_list

    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    #   -- 新規に追加されたタグ
    new_tags = tag_list - current_tags

    p current_tags

    # tag_illustrationテーブルから、(1)のタグを削除
    #   tagsテーブルから該当のタグを探し出して削除する
    old_tags.each do |old|
      # tag_mapsテーブルにあるillustration_idとtag_idを削除
      #   後続のfind_byでtag_idを検索
      self.tags.delete Tag.find_by(name: old)
    end

    # tagsテーブルから(2)のタグを探して、tag_illustrationテーブルにtag_idを追加する
    new_tags.each do |new|
      # 条件のレコードを初めの1件を取得し1件もなければ作成する
      # find_or_create_by : https://railsdoc.com/page/find_or_create_by
      new_illustration_tag = Tag.find_or_create_by(name: new)

      # tag_illustrationテーブルにillustration_idとtag_idを保存
      #   配列追加のようにレコードを渡すことで新規レコード作成が可能
      self.tags << new_illustration_tag
    end

  end
end
