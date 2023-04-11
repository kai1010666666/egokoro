class User::IllustrationsController < ApplicationController
   before_action :authenticate_account!, except: [:index]
  def new
    @illustration = Illustration.new
  end
  
  def create
    @illustration = Illustration.new(illustration_params)
    @illustration.account_id = current_account.id
    if params[:post]
      if @illustration.save
        @illustration.save_tags(params[:illustration][:tag])
        redirect_to illustration_path(@illustration.id), notice: "投稿を公開しました"
      else
        render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
      # 下書きボタンを押下した場合
    else
      if @illustration.update(is_draft: true)
        @illustration.save_tags(params[:illustration][:tag])
        redirect_to account_path(current_account), notice: "投稿を下書き保存しました"
      else
        render :new, alert: "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end
  
  def index
    @illustrations = Illustration.search(params[:search]).published
  end
  
  def show
    @illustration = Illustration.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end
  
  def update
    @illustration = current_account.illustrations.find(params[:id])
    @illustration.assign_attributes(illustration_params)
    if @illustration.save
        @illustration.save_tags(params[:illustration][:tag])
       redirect_to illustration_path(@illustration.id), notice: @illustration.is_draft? ? "下書きを編集しました" : "投稿を編集しました"
    else
       render :edit, alert:"下書きを投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end
  
  def destroy
    @illustration = Illustration.find(params[:id])
    @illustration.destroy
    redirect_to illustrations_path
  end
  
  private
  
  def illustration_params
    params.require(:illustration).permit(:account_id, :title, :introduction, :image, :is_draft, :published_at)
  end
end
