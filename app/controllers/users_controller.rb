class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :update, :show, :edit]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      redirect_to user_path(@user.id), notice: "ユーザが作成されました！"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "投稿できました！"
    else
      render :edit
    end
  end

  def show
    redirect_to pictures_path, notice: "不正操作を記録しました。" unless current_user.id == @users.id
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
