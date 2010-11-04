class PagesController < ApplicationController
  
  def index
    if current_user.present?
      redirect_to statuses_path
      
    end
  end

  def help
    
  end

end


