class PagesController < ApplicationController
  before_filter :check_browser, :except => :unsupported_browser
  def index
    if current_user.present?
      redirect_to statuses_path
    else
      @statuses = Status.latest
    end
  end

  def help
  end

  def unsupported_browser
  end
end


