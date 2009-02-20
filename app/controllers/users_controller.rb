class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new params[:user]
    @user.password = @user.password.crypt(User::PASSWORD_SALT)
    if @user.save
      flash[:notice] = 'Регистрация прошла успешно!'
      redirect_to login_users_path
    else
      @user.password = nil
      flash[:error] = 'Ошибка при регистрации'
      render :action => :new
    end
  end
  
  def login
    @user = User.new
  end
  
  def _login
    @user = User.find_by_login params[:user][:login]
    if @user and @user.password == params[:user][:password].crypt(User::PASSWORD_SALT)
      session[:user_id] = @user.id
      flash[:notice] = "Приветствуем, #{@user.login}"
      redirect_to tasks_path
    else
      flash[:error] = 'Неверное сочетание логин/пароль'
      @user.password = nil
      render :action => :login
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to tasks_path
  end
end
