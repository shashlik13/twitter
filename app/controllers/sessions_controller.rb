class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:danger] = "Неверный email или пароль."
      render "new"
    end
  end
    
  def destroy
    flash[:warning] = "Выход выполнен успешно!"
    sign_out
    redirect_to root_url
  end
  
end