class SessionsController < ApplicationController
    def create
      user = User.find_by(user_mail: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { message: "Login successful", user: user }, status: :ok
      else
        render json: { message: "Invalid email or password" }, status: :unauthorized
      end
    end

    def destroy
      session[:user_id] = nil
      render json: { message: "Logged out" }, status: :ok
    end

    def logged_in
      if session[:user_id]
        render json: { logged_in: true, user: User.find(session[:user_id]) }
      else
        render json: { logged_in: false }
      end
    end
end
