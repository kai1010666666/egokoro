class User::AccountsController < ApplicationController
  def show
    @account = Account.find(params[:id])
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
