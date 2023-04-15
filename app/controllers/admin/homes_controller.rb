class Admin::HomesController < ApplicationController
  def top
      @illustrations_favorite = Illustration.draft_and_published.search(params[:search]).includes(:favorited_accounts).sort {|a,b| b.favorited_accounts.size <=> a.favorited_accounts.size}
      @illustrations_favorite = Kaminari.paginate_array(@illustrations_favorite).page(params[:page]).per(8)
  end
end
