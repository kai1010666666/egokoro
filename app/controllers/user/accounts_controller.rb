class User::AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end
  def show
    @account = Account.find(params[:id])
    @illustrations = @account.illustrations
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
    params.require(:account).permit(:name)
  end
end
