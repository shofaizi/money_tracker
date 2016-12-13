class CallbacksController < ApplicationController
  skip_before_action :authenticate_user

  def twitter
  # step 1. search for a user with the given provider/ uid
  twitter_data = request.env['omniauth.auth']
  user = User.find_from_oauth(twitter_data)
  # step 2. create the user if the user is not found
  if user.nil?
    user ||= User.create_from_oauth(twitter_data)
  end
  # step 3. sign in the user
  session[:user_id] = user.id
  redirect_to root_path, notice: "Thanks for signing up with Twitter!"
  end
end
