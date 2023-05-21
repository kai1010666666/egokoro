class User::TagsController < ApplicationController
  before_action :authenticate_account!
  def index
    @tags = Tag.select do |tag|
      tag.illustrations.published.exists?
    end
    @tags = Kaminari.paginate_array(@tags).page(params[:page]).per(30)
  end

  def show
    @tag = Tag.find(params[:id])
  end

end
