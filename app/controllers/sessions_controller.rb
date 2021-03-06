class SessionsController < ApplicationController
  def new
     
  end

  def create
    #render "new"#    
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user 
      #redirect_to user
      redirect_back_or user
      flash[:success] = "Welcome #{user.name}"
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
