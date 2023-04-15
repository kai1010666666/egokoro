class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tags = Tag.select do |tag|
      tag.illustrations.draft_and_published.exists?
    end
    @tags = Kaminari.paginate_array(@tags).page(params[:page]).per(30)
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to admin_tags_path
  end
end
