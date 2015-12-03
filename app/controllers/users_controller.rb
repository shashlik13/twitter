class UsersController < ApplicationController
  
  before_action :signed_in_user, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      sign_in @user
      flash[:success] = "Добро пожаловать, #{@user.name}  !"
      redirect_to @user
    else
      render "new"
    end
    
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_atrtributes(user_params)
      flash[:success] = "Обновление прошло успешно!"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    user = User.find(params[:id])
    if user
      user.destroy
      flash[:success] = "Пользователь успешно удалён!"
      redirect_to users_path
    else
      flash[:danger] = "Данный пользователь уже удалён или его не существует!"
      redirect_to users_path
    end
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    def signed_in_user
      unless signed_in?
        store_location
        flash[:danger] = "Вы не авторизованы!"
        redirect_to signin_url
      end
    end
    
    def check_user
      user = User.find(params[:id])
      unless current_user?(user)
        flash[:dnger] = "Вы не авторизованы!"
        redirect_to root_url
      end
    end
end