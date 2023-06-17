class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase,password:params[:password])
    if user 
      session[:user_id] = user.id
      redirect_to students_url, notice: "Logged in successfully!"

    else
      redirect_to new_session_path, notice: "Invalid email or password."
     
    end
  end
end