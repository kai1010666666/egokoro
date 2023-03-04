class User::GuestsController < ApplicationController
  def new_guest
    account = Account.find_or_create_by!(email: 'guest@example.com') do |account|
      account.password = SecureRandom.urlsafe_base64
      account.name = "ゲストユーザー"
    end
    sign_in account
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
