class User::AccountsController < ApplicationController
  before_action :authenticate_account!
  def index
    @accounts = Account.page(params[:page]).per(10)
  end
  
  def show
    @account = Account.find(params[:id])
    @illustrations = @account.illustrations.page(params[:page]).per(6)
    @favorites = Favorite.where(account_id: current_account.id)
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    @account.update(account_params)
    redirect_to account_path(current_account.id)
  end
  
  private
  
  def account_params
    params.require(:account).permit(:name, :profile_image)
  end
end
