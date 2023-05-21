class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
      @illustrations_favorite = Illustration.published.search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}
      @illustrations_favorite = Kaminari.paginate_array(@illustrations_favorite).page(params[:page]).per(8)
  end
end
