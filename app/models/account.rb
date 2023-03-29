class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #アソシエーション
  has_many :illustrations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_illustrations, through: :favorites, source: :illustration
  #バリデーション
  validates :name, presence: true
  #プロフィール画像の定義
  has_one_attached :profile_image
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  #ゲストアカウントの定義
  def self.guest
    find_or_create_by!(email: "guest@example.com") do |account|
      account.password = SecureRandom.urlsafe_base64
      account.name = "ゲストアカウント" # ←アカウント名を設定している場合は追加
    end
  end
end
