class User::TagsController < ApplicationController
  def index
    @tags = Tag.select do |tag|
      tag.illustrations.exists?(is_draft: false)
    end
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end
end
