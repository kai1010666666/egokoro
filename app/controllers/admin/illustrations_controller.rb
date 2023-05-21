class Admin::IllustrationsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @illustrations = Illustration.published
  .search(params[:search]).page(params[:page]).per(8)
  end

  def show
    @illustration = Illustration.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @illustration = Illustration.find(params[:id])
    @illustration.destroy
    redirect_to admin_illustrations_path
  end
end
