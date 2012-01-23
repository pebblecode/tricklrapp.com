class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_user_time_zone
  helper_method :user_agent
  helper_method :browser_not_supported?

  private

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end

  def check_browser
    if browser_not_supported?
      redirect_to unsupported_browser_path
    end
  end

  def browser_not_supported? # returns bool true/false
    if user_agent =~ /MSIE/
      version = user_agent.split('MSIE')[1].split(' ').first
      return true if version.to_i < 8
    end
    return false
  end

  def user_agent
    request.env['HTTP_USER_AGENT']
  end
end