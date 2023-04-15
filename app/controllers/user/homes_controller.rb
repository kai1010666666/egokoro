class User::HomesController < ApplicationController
    def top
      @illustrations = Illustration.published.search(params[:search]).last(4).sort.reverse
      @illustrations_favorite = Illustration.published.search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}.first(4)
    end
    
    def about
    end
    
    def rank
      @illustrations_favorite = Illustration.published.search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}
      @illustrations_favorite = Kaminari.paginate_array(@illustrations_favorite).page(params[:page]).per(8)
    end
    
    def guest_sign_in
      user = User.find_or_create_by!(email: 'guest@example.com') do |user|
        user.password = SecureRandom.urlsafe_base64
      end
      sign_in user
      redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
    end
end
