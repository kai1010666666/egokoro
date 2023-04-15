class User::FavoritesController < ApplicationController
  def create
    illustration = Illustration.find(params[:illustration_id])
    favorite = current_account.favorites.new(illustration_id: illustration.id)
    favorite.save
    redirect_to illustration_path(illustration)
  end

  def destroy
    illustration = Illustration.find(params[:illustration_id])
    favorite = current_account.favorites.find_by(illustration_id: illustration.id)
    favorite.destroy
    redirect_to illustration_path(illustration)
  end
end
