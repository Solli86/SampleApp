class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def create 
    @user = User.new(user_params)
    if @user.save 
      sign_in @user
      redirect_to @user
      flash[:success] = "Welcome"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) 
  end

end
