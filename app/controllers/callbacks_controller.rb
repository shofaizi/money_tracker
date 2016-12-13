class CallbacksController < ApplicationController
  skip_before_action :authenticate_user

  def twitter
    twitter_data = request.env['omniauth.auth']
    user = User.find_from_oauth(twitter_data)
    if user.nil?
      user ||= User.create_from_oauth(twitter_data)
    end
    session[:user_id] = user.id
    redirect_to root_path, notice: "Thanks for signing up with Twitter!"
  end
end
