class Admin::UsersController < ApplicationController

  before_filter :restrict_admin
  
  def index
    @users = User.all.order("firstname").page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "#{@user.firstname}'s account is created!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.firstname}'s account is updated!"
    else
      render :edit
    end
  end

    def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path, notice: "Destroyed #{@user.firstname}'s account."
    end

  def switch_to_user
    user = User.find(params[:user_id])
    session[:user_id] = user.id
    redirect_to movies_path, notice: "You are viewing the site as #{user.firstname}."
  end

  def switch_to_admin
    session[:user_id] = session[:admin_user_id]
    redirect_to admin_users_path, notice: "You are in Admin view."
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :is_admin)
  end
  
end