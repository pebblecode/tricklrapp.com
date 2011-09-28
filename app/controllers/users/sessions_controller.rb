class Users::SessionsController < ApplicationController
  def index
  end

  def new
    # Go to homepage for login
    redirect_to root_url
  end

  def destroy
    sign_out
    flash[:notice] = I18n.t 'devise.sessions.signed_out'
    redirect_to root_url
  end
end
