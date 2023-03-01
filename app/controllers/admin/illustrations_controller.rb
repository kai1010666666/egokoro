class Admin::IllustrationsController < ApplicationController
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
  
  def destroy
    @illustration = Illustration.find(params[:id])
    @illustration.destroy
    redirect_to illustrations_path
  end
end
