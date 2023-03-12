class User::IllustrationsController < ApplicationController
  before_action :guest_check, except: [:index, :show]
  
  def new
    @illustration = Illustration.new
  end
  
  def create
    @illustration = Illustration.new(illustration_params)
    @illustration.account_id = current_account.id
    if @illustration.save
      @illustration.save_tags(params[:illustration][:tag])
      redirect_to illustration_path(@illustration.id)
    else
      render :new
    end
  end
  
  def index
    @illustrations = Illustration.search(params[:search])
  end
  
  def show
    @illustration = Illustration.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end
  
  def update
    @illustration = Illustration.find(params[:id])
    if @illustration.update(illustration_params)
      @illustration.save_tags(params[:illustration][:tag])
      redirect_to illustrations_path(@illustration.id)
    else
      render :edit
    end
  end
  
  def destroy
    @illustration = Illustration.find(params[:id])
    @illustration.destroy
    redirect_to illustrations_path
  end
  
  def guest_check
    if current_account == Account.guest
      redirect_to root_path,notice: "このページを見るには会員登録が必要です。"
    end
  end
  
  private
  
  def illustration_params
    params.require(:illustration).permit(:account_id, :title, :introduction, :image)
  end
end
