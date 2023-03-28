class Favorite < ApplicationRecord
  #アソシエーション
  belongs_to :account
  belongs_to :illustration
end
