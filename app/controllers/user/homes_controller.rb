class User::HomesController < ApplicationController
    def top
      @illustrations = Illustration.where(is_draft: false).search(params[:search]).last(4).sort.reverse
      @illustrations_favorite = Illustration.where(is_draft: false).search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}.first(4)
    end
    
    def about
    end
    
    def rank
      @illustrations_favorite = Illustration.where(is_draft: false).search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}
    end
    
    def guest_sign_in
      user = User.find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
        # user.skip_confirmation!  # Confirmable を使用している場合は必要
        # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
      end
      sign_in user
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end
end
