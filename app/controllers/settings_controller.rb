class SettingsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :current_setting

  def index
  end

  def update
    if @setting.update_attributes(params[:setting])
      flash[:notice] = "Your settings were updated"
      redirect_to statuses_path
    else 
      render :action => 'index'
    end        
  end

  private 

  def current_setting
    @setting = current_user.setting
  end

end
