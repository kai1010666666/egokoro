class User::IllustrationsController < ApplicationController
  
  def new
    @illustration = Illustration.new
  end
  
  def create
    @illustration = Illustration.new(illustration_params)
    @illustration.account_id = current_account.id
    # 投稿ボタンを押下した場合
    if params[:post]
      if @illustration.save(context: :publicize)
        @illustration.save_tags(params[:illustration][:tag])
        redirect_to illustration_path(@illustration.id)
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # 下書きボタンを押下した場合
    else
      if @illustration.update(is_draft: true)
        redirect_to account_path(current_account), notice: "下書き保存しました！"
      else
        render :new, alert:"登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
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
  
  private
  
  def illustration_params
    params.require(:illustration).permit(:account_id, :title, :introduction, :image)
  end
end
