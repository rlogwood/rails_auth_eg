class SessionsController < ApplicationController
  # TODO: determine best settings for rate_limit
  rate_limit to: 5, within: 1.minutes, by: -> { request.remote_ip },
             with: -> { head :too_many_requests, alert: "Too many requests"}

    # with: -> { status :too_many_requests }
  def destroy
    logout current_user
    redirect_to root_path, notice: "You have been logged out."
  end

  def new
  end

  def create
    if (user = User.authenticate_by(email: params[:email], password: params[:password]))
      login user
      redirect_to root_path, notice: "You have signed in successfully."
    else
      flash[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
