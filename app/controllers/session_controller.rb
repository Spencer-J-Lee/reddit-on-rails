class SessionController < ApplicationController
  before_action :require_user!, only: %i[destroy]

  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(*user_creds)

    if @user
      login_user!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  
  def user_creds
    [ params[:user][:username], params[:user][:password] ]
  end
end
