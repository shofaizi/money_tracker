class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Thank you for signing up'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find params[:id]
    if @user.update user_params
      flash[:notice] = "Profile updated!"
      render :edit
    end
  end

  def contact_submit
    @user = User.find params[:id]
    flash[:notice] = "Message sent"
  end


  private

  def user_params
    params.require(:user).permit([:first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation])
  end
end
