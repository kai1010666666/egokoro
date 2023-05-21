class User::AccountsController < ApplicationController
  before_action :authenticate_account!
  def index
    @accounts = Account.page(params[:page]).per(10)
  end
  
  def mypage
    @account = current_account
    @illustrations = @account.illustrations.page(params[:page]).per(6)
    @favorites = Favorite.where(account_id: current_account.id).page(params[:page]).per(6)
  end
  
  def show
    @account = Account.find(params[:id])
    @illustrations = @account.illustrations.published.page(params[:page]).per(6)
    @favorites = Favorite.where(account_id: @account.id).page(params[:page]).per(6)
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to account_path(current_account.id)
    else
      render :edit
    end
  end
  
  private
  
  def account_params
    params.require(:account).permit(:name, :profile_image)
  end
end
