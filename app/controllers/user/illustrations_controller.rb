class User::IllustrationsController < ApplicationController
  def new
    @illustration = Illustration.new
  end
  def create
    @illustration = Illustration.new(illustration_params)
    @illustration.save
    redirect_to illustration_path(@illustration.id)
  end
  def index
    @illustrations = Illustration.all
  end

  def show
    @illustration = Illustration.find(params[:id])
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end
  
  def update
    @illustration = Illustration.find(params[:id])
    @illustration.update(illustration_params)
    redirect_to illustrations_path(@illustration.id)
  end
  
  private
  
  def illustration_params
    params.require(:illustration).permit(:account_id,:title,:introduction,:image)
  end
end
