class Admin::AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end
  def show
    @account = Account.find(params[:id])
    @illustrations = @account.illustrations
  end
end
