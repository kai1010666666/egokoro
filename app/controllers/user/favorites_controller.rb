class User::FavoritesController < ApplicationController
  def create
    @illustration = Illustration.find(params[:illustration_id])
    favorite = current_account.favorites.find_or_create_by(illustration_id: @illustration.id)
    render 'user/favorites/toggle'
  end

  def destroy
    @illustration = Illustration.find(params[:illustration_id])
    favorite = current_account.favorites.find_by(illustration_id: @illustration.id)
    favorite.destroy if favorite
    render 'user/favorites/toggle'
  end
end
