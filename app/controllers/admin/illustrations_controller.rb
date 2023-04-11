class Admin::IllustrationsController < ApplicationController
  def index
    @illustrations = Illustration.published
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
