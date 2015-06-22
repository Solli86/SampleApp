class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
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
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
    User.paginate(page: params[:page], :per_page => 3)


  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def new
    @user = User.new
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) 
  end

  def signed_in_user
    store_location
    unless signed_in?
      flash[:warning] = "Please sign in."
      redirect_to signin_path
    end
  end
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
  end

end
